BUNDLE_DIR="~/.vim/bundle"
if [ ! -d "$BUNDLE_DIR" ]; then
    mkdir "$BUNDLE_DIR"
    git clone https://github.com/gmarik/Vundle.vim.git "$BUNDLE_DIR/Vundle.vim"
fi
vim +PluginInstall +qall
