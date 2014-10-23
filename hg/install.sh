#!/bin/sh

EXT_DIR="$HOME/.hg.d/ext"

mkdir -p "$EXT_DIR"
cd "$EXT_DIR"
hg clone https://bitbucket.org/sjl/hg-prompt
hg clone https://bitbucket.org/facebook/hgwatchman
# ..or use git submodules and git-hg
