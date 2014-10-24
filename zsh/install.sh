#!/bin/sh
cd "$(dirname "$0")"
HERE="$(pwd)"

set -e -u -x

if [ ! -e "$HERE/zshrc.local"]; then
    cp $HERE/zshrc.local $HOME/.zshrc.local
fi
