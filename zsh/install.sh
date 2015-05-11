#!/bin/sh
cd "$(dirname "$0")"
HERE="$(pwd)"

set -o errexit
set -o nounset

dest="$HOME/.zshrc.local"
if [ ! -e "$dest" ]; then
    cp "$HERE/zshrc.local" "$dest"
fi
