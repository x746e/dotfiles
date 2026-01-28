#!/usr/bin/env zsh

set -o errexit
set -o nounset

DOTFILES_ROOT="$(dirname "$(dirname "$(realpath $0)")")"

source $DOTFILES_ROOT/scripts/lib.zsh

mkdir -p "$HOME/.gemini"
mkdir -p "$HOME/.gemini/policies"

for link_target in "$DOTFILES_ROOT"/gemini/{commands,GEMINI.md,settings.json}; do
    link_file="$HOME/.gemini/$(basename "$link_target")"
    create_symlink "$link_target" "$link_file"
done

for link_target in "$DOTFILES_ROOT"/gemini/policies/*; do
  link_file="$HOME/.gemini/policies/$(basename "$link_target")"
  create_symlink "$link_target" "$link_file"
done
