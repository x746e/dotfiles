#!/usr/bin/env zsh
# Taken from: https://github.com/holman/dotfiles
#
# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

verbose=""
if [ "$1" = "-v" ]; then
  set -o xtrace
  verbose="-x"
fi
set -o errexit
set -o nounset


info () {
  printf "  [ \033[00;34m..\033[0m ] %s" "$1"
}


user () {
  printf "\r  [ \033[0;33m?\033[0m ] %s " "$1"
}


success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

warn () {
  printf "\r\033[2K  [\033[0;31mWARN\033[0m] %s\n" "$1"
}


fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
  echo ''
  exit
}

# link_file link_target link_file
#   Create a symboilic link ``link_file -> link_target``.
#   Check if there is already link at `link_file` path then
#     * if it points to the same `link_target`, ignore;
#     * otherwise ask user what to do (skip, overwrite, backup and then
#       overwrite).
link_file () {
  # "$filepath:A" normalizes/resolves path in zsh.
  local link_target="$1:A" link_file="$2"

  local overwrite='' backup='' skip=''
  local action=''

  if [ -f "$link_file" -o -d "$link_file" -o -L "$link_file" ]
  then

    if [ "$overwrite_all" = "false" ] && [ "$backup_all" = "false" ] && [ "$skip_all" = "false" ]
    then

      local current_link_target
      current_link_target="$link_file:A"

      if [ "$current_link_target" = "$link_target" ]
      then

        skip=true;

      else

        user "File already exists: $(basename "$link_target"), what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -k action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite="${overwrite:-$overwrite_all}"
    backup="${backup:-$backup_all}"
    skip="${skip:-$skip_all}"

    if [ "$overwrite" = "true" ]
    then
      rm -rf "$link_file"
      success "removed $link_file"
    fi

    if [ "$backup" = "true" ]
    then
      mv "$link_file" "${link_file}.backup"
      success "moved $link_file to ${link_file}.backup"
    fi

    if [ "$skip" = "true" ]
    then
      success "skipped $link_target"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}


# install_dotfiles
#   For all files/directories with `.symlink` suffix in the name, link them into $HOME.
install_dotfiles () {
  info 'installing dotfiles'

  # Shell has dynamic scoping; these variables will be accessible in `link_file` function.
  local overwrite_all=false backup_all=false skip_all=false

  for link_target in $(find "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink')
  do
    link_file="$HOME/.$(basename "${link_target%.*}")"
    link_file "$link_target" "$link_file"
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
