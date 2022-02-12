#!/usr/bin/env zsh

set -o errexit
set -o nounset

DOTFILES_ROOT="$(dirname "$(dirname "$(realpath $0)")")"

source $DOTFILES_ROOT/scripts/lib.zsh

mkdir -p "$HOME/bin"

for link_target in $(find "$DOTFILES_ROOT/git/scripts" -maxdepth 1 -name 'git-*' -type f); do
  link_file="$HOME/bin/$(basename "$link_target")"
  create_symlink "$link_target" "$link_file"
done
