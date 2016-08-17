#!/bin/sh

set -o errexit
set -o nounset

if ! which git > /dev/null; then
  exit
fi
if ! which vim > /dev/null; then
  exit
fi


mkdir -p "$HOME/.vimtags"


BUNDLE_DIR="$HOME/.vim/bundle"
if [ ! -d "$BUNDLE_DIR/Vundle.vim" ]; then
    mkdir "$BUNDLE_DIR"
    git clone https://github.com/gmarik/Vundle.vim.git "$BUNDLE_DIR/Vundle.vim"
fi
vim +PluginInstall +qall >/dev/null 2>&1
