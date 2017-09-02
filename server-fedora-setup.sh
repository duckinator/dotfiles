#!/usr/bin/env bash

# Setup script for Fedora servers.

# Latest version: https://github.com/duckinator/dotfiles/raw/main/server-fedora-setup.sh

CHRUBY_VERSION=0.3.9
RUBY_INSTALL_VERSION=0.6.1

sudo su -c "dnf -y update &&\
  dnf -y install git zsh htop ruby clang gcc-c++ cmake make &&\
  dnf -y groupinstall 'Development Tools'"

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
  git clone https://github.com/duckinator/dotfiles.git .dotfiles
fi

if ! [ -f "$HOME/.zshrc" ]; then
  cd .dotfiles &&
  gem install -r bundler &&
  bundle install &&
  effuse

  # If we're using one that throws things in ~/bin, then it's the system Ruby.
  if [ "$(which effuse)" = "$HOME/bin/effuse" ]; then
    gem uninstall -x bundler effuse

    rmdir $HOME/bin 2>/dev/null
  fi
fi
