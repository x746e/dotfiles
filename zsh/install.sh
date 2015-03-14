#!/bin/sh
cd "$(dirname "$0")"
HERE="$(pwd)"

set -e -u -x

if [ ! -e "$HOME/zshrc.local" ]; then
    cp $HERE/zshrc.local $HOME/.zshrc.local
fi
