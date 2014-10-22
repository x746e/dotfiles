#!/bin/sh
cd "$(dirname "$0")"
HERE="$(pwd)"

set -e -u -x

cp $HERE/zshrc.local $HOME/.zshrc.local
