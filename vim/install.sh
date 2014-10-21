BUNDLE_DIR="$HOME/.vim/bundle"
if [ ! -d "$BUNDLE_DIR/Vundle.vim" ]; then
    mkdir "$BUNDLE_DIR"
    git clone https://github.com/gmarik/Vundle.vim.git "$BUNDLE_DIR/Vundle.vim"
fi
vim +PluginInstall +qall

# fb staff
if [ -e "/mnt/vol/engshare/admin/scripts/vim" ]; then
    mkdir -p ~/.vim/after/indent ~/.vim/after/syntax
    if [ ! -f ~/.vim/after/indent/php.vim ]; then
        ln -s /mnt/vol/engshare/admin/scripts/vim/after/indent/php.vim ~/.vim/after/indent
    fi
    if [ ! -f ~/.vim/after/syntax/php.vim ]; then
        ln -s /mnt/vol/engshare/admin/scripts/vim/after/syntax/php.vim ~/.vim/after/syntax
    fi
fi
