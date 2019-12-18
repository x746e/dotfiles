import subprocess

class AttachByName(gdb.Command):
    def __init__(self):
        super(AttachByName, self).__init__('attach-by-name', gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        try:
            out = subprocess.check_output('pgrep -x %s' % arg, shell=True).strip()
        except subprocess.CalledProcessError:
            raise gdb.GdbError("No process called '%s' was found." % arg)
        assert out, 'empty output'
        pids = map(int, out.split())
        if len(pids) > 1:
            raise gdb.GdbError("There are more than one process called '%s'." % arg)
        (pid,) = pids
        gdb.execute('attach %d' % pid, from_tty=from_tty)

AttachByName()
