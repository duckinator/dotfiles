#!/bin/bash

if [ "$1" = "create" ]; then
    git clone https://github.com/nvm-sh/nvm.git ~/.nvm
    cd ~/.nvm
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
fi

if [ "$1" = "clean" ]; then
    rm -rf ~/.nvm
fi
