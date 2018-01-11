#!/usr/bin/env bash

sudo su -c "dnf -y update &&\
  dnf -y install git fish htop ruby && \
  dnf -y install xfce4-terminal hexchat firefox && \
  dnf groupinstall 'Development Tools'"

if [ ! -d "$HOME/.dotfiles" ]; then
  git clone https://github.com/duckinator/dotfiles.git $HOME/.dotfiles && \
  cd $HOME/.dotfiles && \
  gem install effuse && \
  effuse
fi
