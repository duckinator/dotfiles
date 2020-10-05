#!/bin/bash

if [ "$1" = "create" ]; then
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv
fi

if [ "$1" = "clean" ]; then
    rm -rf ~/.tfenv
fi
