#!/bin/bash

if [ "$(cat ~/.screen-can-rotate)" == "true"]; then
  echo -n false > ~/.screen-can-rotate
else
  echo -n true > ~/.screen-can-rotate
fi
