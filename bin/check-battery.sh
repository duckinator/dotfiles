#!/bin/bash

upower -i $(upower -e | grep -i battery)
