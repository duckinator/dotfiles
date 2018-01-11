#!/bin/bash

npm install themer themer-colors-lucid themer-vim && \
rm -rf .themer-build/ && \
themer -c ./data/theme.js -t themer-vim -o .themer-build && \
ln -s $(pwd)/.themer-build/themer-vim/ThemerVim.vim $(pwd)/.vim/colors/ThemerVim.vim
#themer -c themer-colors-lucid -t themer-vim -o ./.vim
