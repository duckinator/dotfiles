#!/bin/bash

DIR=$(dirname $(readlink -f $0)) # Directory script is in
cd $DIR

OLD_OUTPUT=""

while true; do
  if [ -f ~/.screen-can-rotate ]; then
    OUTPUT="$(./screen-rotate.sh --if-needed "$OUTPUT")"
  fi
  sleep 1
done
