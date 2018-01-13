#!/bin/bash

npx -p themer -p themer-vim -c 'themer -c ./data/theme.js -t themer-vim -o .themer-build' && \
mv ./.themer-build/themer-vim/ThemerVim.vim .vim/colors/ThemerVim.vim && \
rmdir ./.themer-build/themer-vim/ ./.themer-build/
