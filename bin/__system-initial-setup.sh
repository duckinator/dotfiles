#!/usr/bin/env bash

if [ "$(uname)" = "FreeBSD" ]; then
  sudo pkg install sudo git fish htop ruby neovim tree xfce xorg hexchat firefox || exit 1
  sudo pkg install $(ruby --version | cut -d '.' -f 1-2 | sed 's/[ .]//g')-gems  || exit 1

  # TODO: docker-machine?

  exit
fi

if [ -n "$(which pacman 2>/dev/null)" ]; then
  package_manager=pacman
  _python3=python
elif [ -n "$(which dnf 2>/dev/null)" ]; then
  package_manager=dnf
  _python3=python3
else
  echo "Not sure what distro this is! Exiting!"
  echo "(Currently supports Manjaro and Fedora.)"
  exit 1
fi

BASE_DEVEL="binutils gawk grep gzip make patch pkg-config sed sudo util-linux which"
COMMON_PACKAGES="git fish htop ruby neovim ${_python3}-neovim tree xfce4-terminal hexchat firefox docker"

PACKAGES="${BASE_DEVEL} ${COMMON_PACKAGES}"

case $package_manager in
pacman)
  sudo pacman -Syyu &&
    sudo pacman -S $PACKAGES pacaur || exit 1
  ;;
dnf)
  sudo dnf -y update &&
    sudo dnf -y install $PACKAGES || exit 1
esac

if ! [ -d "$HOME/dotfiles" ]; then
  pushd $HOME && \
    git clone https://github.com/duckinator/dotfiles.git && \
    pushd dotfiles && \
      gem install -r effuse && \
      effuse -c && \
      effuse
    popd
  popd
fi
