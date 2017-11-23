#!/usr/bin/env bash

# Setup script for Fedora.

CHRUBY_VERSION=0.3.8
RUBY_INSTALL_VERSION=0.4.3

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 [--dev] [--gui]"
  exit
fi

if [ "$1" == "--dev" ] || [ "$2" == "--dev" ]; then
  DEVTOOLS_PACKAGES="clang gcc-c++ cmake make"
fi

if [ "$1" == "--gui"] || [ "$2" == "--gui" ]; then
  GUI_PACKAGES="mate-terminal xchat firefox pidgin"
fi

sudo su -c "yum -y update &&\
  yum -y install git zsh htop ruby $GUI_PACKAGES $FLASH_PACKAGES $SKYPE_PACKAGES &&\
  $INSTALL_DEVTOOLS && yum groupinstall 'Development Tools' && yum install $DEVTOOLS_PACKAGES"

cd $HOME

if ! [ -f "/usr/local/bin/chruby-exec" ]; then
  curl -L https://github.com/postmodern/chruby/archive/v${CHRUBY_VERSION}.tar.gz | tar xzf - &&
  cd chruby-${CHRUBY_VERSION} && sudo make install && cd .. && rm -rf chruby-${CHRUBY_VERSION}
fi

if ! [ -f "/usr/local/bin/ruby-install" ]; then
  curl -L https://github.com/postmodern/ruby-install/archive/v${RUBY_INSTALL_VERSION}.tar.gz | tar xzf - &&
  cd ruby-install-${RUBY_INSTALL_VERSION} && sudo make install && cd .. && rm -rf ruby-install-${RUBY_INSTALL_VERSION}
fi

if ! [ -d "$HOME/.dotfiles" ]; then
  git clone git@github.com:duckinator/dotfiles.git .dotfiles
fi

if ! [ -f "$HOME/.zshrc" ]; then
  cd .dotfiles &&
  gem install effuse &&
  effuse
fi
