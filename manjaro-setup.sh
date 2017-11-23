#!/usr/bin/env bash

# Setup script for Manjaro Linux.

DEFAULT_PACKAGES="git zsh htop vim pacaur tree base-devel"
AUR_PACKAGES="ruby-install chruby"

PACMAN_MIRRORS_COMMAND="echo -n"

# Make entire script fail if any commands fail.
set -e

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 [--gui] [--mirrors]"
  exit
fi

if [[ "$1" == "--gui" ]]; then
  GUI_PACKAGES="xfce4-terminal hexchat firefox"
fi

if [[ "$1" == "--mirrors" ]] || [[ "$2" == "--mirrors" ]]; then
  PACMAN_MIRRORS_COMMAND="pacman-mirrors -g"
fi

# Packages in the normal repos.
sudo su -c "\
  $PACMAN_MIRRORS_COMMAND &&\
  pacman -Syyu &&\
  pacman -S $DEFAULT_PACKAGES $GUI_PACKAGES"

pacaur -S $AUR_PACKAGES

cd $HOME

if ! [ -d "$HOME/.dotfiles" ]; then
  git clone git@github.com:duckinator/dotfiles.git .dotfiles
fi

if ! [ -f "$HOME/.zshrc" ]; then
  source /usr/share/chruby/chruby.sh
  chruby ruby

  cd .dotfiles &&
  gem install -r effuse &&
  effuse &&
  ./vim-plug.sh
fi

