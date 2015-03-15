#!/bin/sh

set -o errexit
set -o nounset

if ! which hg > /dev/null; then
  exit
fi

EXT_DIR="$HOME/.hg.d/ext"

mkdir -p "$EXT_DIR"
cd "$EXT_DIR"

if [ ! -d hg-prompt ]; then
    hg clone https://bitbucket.org/sjl/hg-prompt
fi
if [ ! -d hgwatchman ]; then
    hg clone https://bitbucket.org/facebook/hgwatchman
    # TODO: Try to build it.
fi
# ..or use git submodules and git-hg
