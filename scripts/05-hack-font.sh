#!/bin/bash

FONTDIR="$HOME/.fonts"

if [ "$1" = "create" ]; then
    mkdir -p "$FONTDIR"

    TMPDIR="$(mktemp -d)"
    cd "$TMPDIR"
    wget -O hack.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
    unzip hack.zip
    mv ttf/*.ttf "$FONTDIR"

    cd
    rm -rf "$TMPDIR"
fi

if [ "$1" = "clean" ]; then
    [ -d "$FONTDIR" ] || exit
    cd "$FONTDIR"
    rm -f Hack-*.ttf
fi

# Always run this after playing with fonts.
fc-cache -f -v
