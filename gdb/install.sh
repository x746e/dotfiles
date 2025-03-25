#!/bin/bash -eux

HERE="$(dirname "$(realpath $0)")"

GDB_CONF_DIR="$HOME/.config/gdb"

mkdir -p "$GDB_CONF_DIR/"
ln -s "$HERE/gdbinit" "$GDB_CONF_DIR/gdbinit"
mkdir -p "$GDB_CONF_DIR/gdbinit.d/"
