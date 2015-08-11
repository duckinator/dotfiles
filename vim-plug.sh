#!/bin/bash

[ -f "/usr/local/share/chruby/chruby.sh" ] && source /usr/local/share/chruby/chruby.sh
[ -n "$CHRUBY_VERSION" ] && chruby system

mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c PlugUpdate -c qa
