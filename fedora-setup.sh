#!/usr/bin/env bash

# Setup script for Fedora.

# Latest version: https://github.com/duckinator/dotfiles/raw/main/setup.sh

CHRUBY_VERSION=0.3.8
RUBY_INSTALL_VERSION=0.4.3

SKYPE_FILE="$HOME/skype-fedora.i586.rpm"

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
prompt "Install nonfree software (Flash, Skype, etc)?" NONFREE_INSTALL no
prompt "Install Development Tools package group?" INSTALL_DEVTOOLS yes

if $GUI_INSTALL; then
  GUI_PACKAGES="mate-terminal xchat firefox pidgin"
fi

if $GUI_INSTALL && $NONFREE_INSTALL; then
  prompt "Install flash?" USE_FLASH no
  prompt "Install Skype?" USE_SKYPE no
fi

if $USE_FLASH; then
  sudo yum -y install http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm

  sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux

  FLASH_PACKAGES="flash-plugin"
fi

if $USE_SKYPE; then
  # https://ask.fedoraproject.org/en/question/8738/how-to-install-skype/
  # and
  # http://fedorasolved.org/Members/dcr226/installing-skype

  if ! [ -f "/etc/yum.repos.d/skype.repo" ]; then
    sudo gpg --keyserver pgp.mit.edu --recv-keys 0xD66B746E
    sudo gpg -a -o /etc/pki/rpm-gpg/RPM-GPG-KEY-skype --export 0xD66B746E

    echo "[skype]
name=Skype Repository
baseurl=http://download.skype.com/linux/repos/fedora/updates/i586/
#gpgkey=http://www.skype.com/products/skype/linux/rpm-public-key.asc
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-skype
enabled=1
gpgcheck=1" | sudo tee /etc/yum.repos.d/skype.repo >/dev/null 
  fi

  curl -L https://www.skype.com/go/getskype-linux-beta-fc10 > $SKYPE_FILE

  SKYPE_PACKAGES="libXv.i?86 libXScrnSaver.i?86 qt.i?86 qt-x11.i?86 pulseaudio-libs.i?86 pulseaudio-libs-glib2.i?86 alsa-plugins-pulseaudio.i?86"
  SKYPE_NOGPGCHECK_PACKAGES="$SKYPE_FILE"
fi

if $INSTALL_DEVTOOLS; then
  DEVTOOLS_PACKAGES="clang gcc-c++ cmake make"
fi

sudo su -c "yum -y update &&\
  yum -y install git zsh htop ruby $GUI_PACKAGES $FLASH_PACKAGES $SKYPE_PACKAGES &&\
  yum -y install $SKYPE_NOGPGCHECK_PACKAGES --nogpgcheck;\
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
  gem install -r bundler &&
  bundle install &&
  effuse

  # If we're using one that throws things in ~/bin, then it's the system Ruby.
  if [ "$(which effuse)" = "$HOME/bin/effuse" ]; then
    gem uninstall -x bundler effuse

    rmdir $HOME/bin 2>/dev/null
  fi
fi

[ -f "$SKYPE_FILE" ] && rm $SKYPE_FILE
