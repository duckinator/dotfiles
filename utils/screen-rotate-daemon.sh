#!/bin/bash

DIR=$(dirname $(readlink -f $0)) # Directory script is in
cd $DIR

OLD_OUTPUT=""

while true; do
  if [ "$(cat ~/.screen-can-rotate.txt)" == "true" ]; then
    OUTPUT="$(./screen-rotate.sh "$OUTPUT")"
  fi
  sleep 1
done
