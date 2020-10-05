#!/bin/bash

if [ "$1" = "create" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh
    sh /tmp/rustup.sh -y --no-modify-path
    rm /tmp/rustup.sh
fi

if [ "$1" = "clean" ]; then
    if which rustup &>/dev/null; then
        rustup self uninstall -y
    fi
fi
