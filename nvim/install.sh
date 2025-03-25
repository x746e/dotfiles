#!/bin/bash -eux

HERE="$(dirname "$(realpath $0)")"

CONF_DIR="$HOME/.config"

ln -sf "$HERE/dot-config-nvim/" "$CONF_DIR/nvim"
