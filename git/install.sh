#!/usr/bin/env zsh

set -o errexit
set -o nounset

DOTFILES_ROOT="$(dirname "$(dirname "$(realpath $0)")")"

source $DOTFILES_ROOT/scripts/lib.zsh

for link_target in $(find "$DOTFILES_ROOT/git/scripts" -name 'git-*' -maxdepth 1 -type f); do
  link_file="$HOME/bin/$(basename "$link_target")"
  create_symlink "$link_target" "$link_file"
done
