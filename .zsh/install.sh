#!/usr/bin/env bash

DIR=$(dirname $(readlink -f $0))
_REMOTE=false

if [ -f "$HOME/.zshrc" ]; then
    echo "Backing up ~/.zshrc..."
    cp $HOME/.zshrc $HOME/.zshrc.bak
fi

if [ -f "$HOME/.zshenv" ]; then
    echo "Backing up ~/.zshenv..."
    cp $HOME/.zshenv $HOME/.zshenv.bak
fi

if [ "$1" == "remote" ]; then
  echo "Performing install for remote system..."
  _REMOTE=true
fi

if $_REMOTE; then
  cat $DIR/default.zshrc  | sed 's/^#remote/remote/g' > $HOME/.zshrc
  cat $DIR/default.zshenv | sed 's/^#remote/remote/g' > $HOME/.zshenv
else
  cp $DIR/default.zshrc  $HOME/.zshrc
  cp $DIR/default.zshenv $HOME/.zshenv
fi
