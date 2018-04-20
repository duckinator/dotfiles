#!/usr/bin/env bash

if [ -d "$HOME/dotfiles" ]; then
  exit
fi

git clone https://github.com/duckinator/dotfiles.git $HOME/dotfiles && \
  cd $HOME/dotfiles && \
  gem install -r effuse && \
  effuse -c && \
  effuse
