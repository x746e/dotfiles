#!/usr/bin/env python3
# vim: ts=4:sts=4:sw=4
from subprocess import check_call, check_output, CalledProcessError


def main():
    branches = get_branches()
    # Get all preamend branches
    preamend_branches = [branch for branch in branches if branch.startswith('preamend-')]

    for preamend_branch in preamend_branches:
        amended_branch = preamend_branch[len('preamend-'):]
        rebase_children(amended_branch, preamend_branch)
        drop_branch(preamend_branch)


def abort():
    """
    Abort unsuccessful amend.
    """
    checkout_branch('master')
    preamend_branches = [branch for branch in get_branches() if branch.startswith('preamend-')]

    # For each preamend-(.*) branch:
    for preamend_branch in preamend_branches:
        amended_branch = preamend_branch[len('preamend-'):]
        # delete corresponding \1 branch
        drop_branch(amended_branch)
        # remove preamend- prefix
        rename_branch(preamend_branch, amended_branch)


def get_branches():
    return [line.decode('utf-8') for line in
            check_output("git branch | sed -e 's/^[* ]*//'", shell=True).splitlines()]


def checkout_branch(branch):
    run("git co '%s'" % branch)


def drop_branch(branch):
    run("git branch -D '%s'" % branch)


def rename_branch(old_name, new_name):
    run("git branch -m '{old}' '{new}'".format(old=old_name, new=new_name))


def rebase_children(amended_branch, preamend_branch):
    branches = get_branches()
    # Get all direct child branches of preamend branch (not grandchildren).
    descedants = [
        branch for branch in branches
        if is_descedant(branch, preamend_branch)
    ]
    children = [
        branch for branch in descedants
        if not any([is_descedant(branch, another) for another in descedants])
            and not branch.startswith('preamend-')
    ]

    # Rebase children.
    for child in children:
        preamend_child = 'preamend-%s' % child
        try:
            rebase(onto=amended_branch, upstream=preamend_branch, branch=child)
        except CalledProcessError:
            run("git st")
            print("Seems like a conflict during rebase.  Fix the conflict, run "
                  "git add .; git rebase --continue, and then git amend-fixup again")
            exit(1)
        rebase_children(amended_branch=child, preamend_branch=preamend_child)
        # Cleanup successfully rebased children.
        preamend_child_has_children = [branch for branch in get_branches()
                                       if is_descedant(branch, preamend_child)]
        assert not preamend_child_has_children
        drop_branch(preamend_child)


def is_descedant(branch, ancestor):
    """Whether `ancestor` in an ancestor of `branch`."""
    if branch == ancestor:
        return False
    descedants = [
        line.decode('utf-8') for line in
        check_output("git branch --contains '%s' | sed -e 's/^[* ]*//'" % ancestor, shell=True).splitlines()
    ]
    return branch in descedants


def run(cmd):
    print(">> executing: %s" % cmd)
    check_call(cmd, shell=True)


def rebase(onto, upstream, branch):
    run("git branch 'preamend-{branch}' '{branch}'".format(branch=branch))
    run("git rebase --onto '%s' '%s' '%s'" % (onto, upstream, branch))
