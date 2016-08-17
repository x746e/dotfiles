#!/usr/bin/env zsh
# Taken from: https://github.com/holman/dotfiles
#
# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES_ROOT="$(pwd)"


source "$DOTFILES_ROOT/scripts/lib.sh"


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

  # Shell has dynamic scoping; these variables will be accessible in `create_symlink` function.
  local overwrite_all=false backup_all=false skip_all=false

  for link_target in $(find "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink')
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
    sh $verbose "$installer"
    success "$installer succeeded"
  done
}


install_dotfiles
run_installers


success 'All installed!'
# vim: ts=2:sts=2:sw=2
