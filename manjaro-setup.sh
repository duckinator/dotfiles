#!/usr/bin/env bash

# Setup script for Manjaro Linux.

# Latest version: https://github.com/duckinator/dotfiles/raw/main/manjaro-setup.sh

DEFAULT_PACKAGES="git zsh htop vim pacaur tree"
AUR_DEFAULT_PACKAGES="ruby-install chruby"

# TODO: make this optional.
#PACMAN_MIRRORS_COMMAND="pacman-mirrors -g"
PACMAN_MIRRORS_COMMAND="echo -n"

# Make entire script fail if any commands fail.
set -e

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 [OPTION]..."
  echo
  echo "Options:"
  echo "  -h, --help"
  echo "         Display this help message and then exit."
  echo "  -y, --assumeyes"
  echo "         Assume yes; assume that the answer to any question which would be asked is yes."
  echo 
  exit
fi

if [ "$1" = "-y" ] || [ "$1" = "--assumeyes" ]; then
  ASSUME_YES=true
fi

function normalize_response() {
  case $response in
  y|Y|yes)
    response=true
    ;;
  n|N|no)
    response=false
    ;;
  *)
    response="invalid"
    return 1
    ;;
  esac

  return 0
}

function prompt() {
  if [ $ASSUME_YES ]; then
    eval "$2=true"
    return
  fi

  response=""
  default=$3
 
  if normalize_response $default ; then
    YN="Y/n" 
  else
    YN="y/N"
  fi

  while ! normalize_response $response; do
    printf "$1 [$YN] "
    read response

    if [ -z "$response" ]; then
      response=$default
    fi
  done

  eval "$2=$response"

  unset response default
}

prompt "Is this a graphical installation?" GUI_INSTALL yes

if $GUI_INSTALL; then
  GUI_PACKAGES="xfce4-terminal hexchat opera"

#  prompt "Install flash?" USE_FLASH no
  prompt "Install Skype?" USE_SKYPE no
fi

#if $USE_FLASH; then
  # TODO
  #AUR_FLASH_PACKAGES="flash-plugin"
#fi

if $USE_SKYPE; then
  AUR_SKYPE_PACKAGES="skypeforlinux-bin"
fi

# Packages in the normal repos.
sudo su -c "\
  $PACMAN_MIRRORS_COMMAND &&\
  pacman -Syyu &&\
  pacman -S $DEFAULT_PACKAGES $MANJARO_SPECIFIC_PACKAGES"

# Don't do `yaourt -Syu` because gstreamer0.10 is broken.
# https://aur.archlinux.org/packages/gstreamer0.10/
#yaourt -Syu --devel --aur &&\
pacaur -S $AUR_DEFAULT_PACKAGES $AUR_FLASH_PACKAGES $AUR_SKYPE_PACKAGES

cd $HOME

if ! [ -d "$HOME/.dotfiles" ]; then
  git clone git@github.com:duckinator/dotfiles.git .dotfiles
fi

if ! [ -f "$HOME/.zshrc" ]; then
  source /usr/share/chruby/chruby.sh
  chruby ruby

  cd .dotfiles &&
  gem install -r bundler &&
  bundle install &&
  bundle exec effuse &&
  ./vim-plug.sh
fi

