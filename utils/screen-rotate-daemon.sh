#!/bin/bash

DIR=$(dirname $(readlink -f $0)) # Directory script is in
cd $DIR

OLD_OUTPUT=""

while true; do
  OUTPUT="$(./screen-rotate.sh "$OUTPUT")"
  sleep 1
done
