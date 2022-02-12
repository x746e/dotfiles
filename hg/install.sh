#!/bin/sh

set -o errexit
set -o nounset

if ! which hg > /dev/null; then
  exit
fi

EXT_DIR="$HOME/.hg.d/ext"

mkdir -p "$EXT_DIR"
cd "$EXT_DIR"
