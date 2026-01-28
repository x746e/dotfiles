#!/bin/sh -x

set -o errexit
set -o nounset

if ! which git > /dev/null; then
  echo "Git isn't installed, exiting" 1>&2
  exit 1
fi
if ! which vim > /dev/null; then
  echo "VIM isn't installed, exiting" 1>&2
  exit 1
fi


mkdir -p "$HOME/.vimtags"


BUNDLE_DIR="$HOME/.vim/bundle"
if [ ! -d "$BUNDLE_DIR/Vundle.vim" ]; then
    mkdir "$BUNDLE_DIR"
    git clone https://github.com/gmarik/Vundle.vim.git "$BUNDLE_DIR/Vundle.vim"
fi
vim +PluginInstall +qall >/dev/null 2>&1
