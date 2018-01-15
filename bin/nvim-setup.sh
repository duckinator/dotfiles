#!/bin/bash

PLUGIN_DIR="${HOME}/.config/nvim/bundle"
INSTALL_DIR="${PLUGIN_DIR}/repos/github.com/Shougo/dein.vim"

mkdir -p $INSTALL_DIR
git clone https://github.com/Shougo/dein.vim $INSTALL_DIR
