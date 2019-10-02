#!/usr/bin/env zsh
# Taken from: https://github.com/holman/dotfiles
#
# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES_ROOT="$(pwd)"
DOTFILES_EXT_ROOT="$HOME/dotfiles-ext"

source "$DOTFILES_ROOT/scripts/lib.zsh"


verbose=""
if [ "$1" = "-v" ]; then
  set -o xtrace
  verbose="-x"
fi
set -o errexit
set -o nounset


# install_dotfiles
#   For all files/directories with `.symlink` suffix in the name, link them into $HOME.
install_dotfiles () {
  info 'installing dotfiles'

  roots=($DOTFILES_ROOT)
  if [[ -d "$DOTFILES_EXT_ROOT" ]]; then
    roots+=($DOTFILES_EXT_ROOT)
  fi

  for link_target in $(find "$roots[@]" -maxdepth 2 -name '*.symlink')
  do
    link_file="$HOME/.$(basename "${link_target%.*}")"
    create_symlink "$link_target" "$link_file"
  done
}


# run_installers
#   Run custom `install.sh` scripts.
run_installers () {
  for installer in $(find "$DOTFILES_ROOT" -maxdepth 2 -name install.sh \! -path '*/scripts/install.sh')
  do
    info "running $installer"
    "$installer"
    success "$installer succeeded"
  done
}


install_dotfiles
run_installers


success 'All installed!'
# vim: ts=2:sts=2:sw=2
