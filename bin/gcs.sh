#!/usr/bin/env bash

VERSION=4.10.0
FOLDER=gcs-$VERSION-linux

URL=https://github.com/richardwilkes/gcs/releases/download/gcs-$VERSION/gcs-$VERSION-linux.zip

if [ ! -d "$HOME/$FOLDER" ]; then
  cd $HOME || exit 1
  wget $URL || exit 1
  unzip $FOLDER.zip || exit 1
  rm $FOLDER.zip || exit 1
fi

$HOME/$FOLDER/gcs
