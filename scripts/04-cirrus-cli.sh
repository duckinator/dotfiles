#!/bin/bash

FILE="$HOME/bin/cirrus"

if [ "$1" = "create" ]; then
    wget -O "$FILE" https://github.com/cirruslabs/cirrus-cli/releases/latest/download/cirrus-linux-amd64
    chmod +x "$FILE"
fi

if [ "$1" = "clean" ]; then
    [ -f "$FILE" ] && rm "$FILE"
fi
