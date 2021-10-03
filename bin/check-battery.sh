#!/usr/bin/env bash

upower -i $(upower -e | grep -i battery)
