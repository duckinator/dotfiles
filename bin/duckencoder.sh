#!/usr/bin/env bash

if [ ! -d "$HOME/USB-Rubber-Ducky" ]; then
  pushd $HOME || exit 1
  git clone git@github.com:hak5darren/USB-Rubber-Ducky.git || exit 1
  popd || exit 1
fi

pushd $HOME/USB-Rubber-Ducky || exit 1
git pull || exit 1
popd || exit 1

java -jar $HOME/USB-Rubber-Ducky/duckencoder.jar "$@"
