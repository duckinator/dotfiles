#!/bin/bash

if [ -f ~/.screen-can-rotate ]; then
  rm ~/.screen-can-rotate
else
  touch ~/.screen-can-rotate
fi
