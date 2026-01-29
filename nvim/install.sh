#!/usr/bin/env zsh

set -o errexit
set -o nounset

DOTFILES_ROOT="$(dirname "$(dirname "$(realpath $0)")")"
source "$DOTFILES_ROOT/scripts/lib.zsh"

HERE="$(dirname "$(realpath $0)")"
CONF_DIR="$HOME/.config"

mkdir -p "$CONF_DIR"
create_symlink "$HERE/dot-config-nvim" "$CONF_DIR/nvim"