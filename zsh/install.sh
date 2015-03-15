#!/bin/sh
cd "$(dirname "$0")"
HERE="$(pwd)"

set -o errexit
set -o nounset

if [ ! -e "$HOME/zshrc.local" ]; then
    cp $HERE/zshrc.local $HOME/.zshrc.local
fi
