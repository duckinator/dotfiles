#!/bin/bash

DEFAULT_PACKAGES="git zsh htop vim pacaur tree base-devel"

COMMON_PACKAGES="git fish htop ruby vim tree xfce4-terminal hexchat firefox"

if [ -n "$(which pacman 2>/dev/null)" ]; then
  sudo su -c "\
    pacman -Syyu && \
    pacman -S $COMMON_PACKAGES pacaur base-devel" || exit 1
elif [ -n "$(which dnf 2>/dev/null)" ]; then
  sudo su -c "\
    dnf -y update && \
    dnf -y install $COMMON_PACKAGES && \
    dnf groupinstall 'Development Tools'" || exit 1
else
  echo "Not sure what distro this is! Exiting!"
  echo "(Currently supports Manjaro and Fedora.)"
  exit 1
fi

if ! [ -d "$HOME/dotfiles" ]; then
  pushd $HOME && \
    git clone https://github.com/duckinator/dotfiles.git && \
    pushd dotfiles && \
      gem install -r effuse && \
      effuse
    popd
  popd
fi
