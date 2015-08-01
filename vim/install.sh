#!/bin/sh

set -o errexit
set -o nounset

if ! which git > /dev/null; then
  exit
fi
if ! which vim > /dev/null; then
  exit
fi

BUNDLE_DIR="$HOME/.vim/bundle"
if [ ! -d "$BUNDLE_DIR/Vundle.vim" ]; then
    mkdir "$BUNDLE_DIR"
    git clone https://github.com/gmarik/Vundle.vim.git "$BUNDLE_DIR/Vundle.vim"
fi
vim +PluginInstall +qall >/dev/null 2>&1

# fb stuff
if [ -e "/mnt/vol/engshare/admin/scripts/vim" ]; then
    mkdir -p ~/.vim/after/indent ~/.vim/after/syntax
    if [ ! -e ~/.vim/after/indent/php.vim ]; then
        ln -s /mnt/vol/engshare/admin/scripts/vim/after/indent/php.vim ~/.vim/after/indent/php.vim
    fi
    if [ ! -e ~/.vim/after/syntax/php ]; then
        ln -s /mnt/vol/engshare/admin/scripts/vim/after/syntax/php ~/.vim/after/syntax/php
    fi
fi
