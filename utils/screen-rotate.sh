#!/bin/bash

ORIENTATION="$(qdbus --system net.hadess.SensorProxy /net/hadess/SensorProxy net.hadess.SensorProxy.AccelerometerOrientation)"

XRANDR_OUTPUT="$(xrandr | grep "connected primary" | cut -d ' ' -f 1)"

XINPUT_DEVICE_NAME="Virtual core pointer"
XINPUT_TRANSFORM="Coordinate Transformation Matrix"

function xrandr-rotate() {
  xrandr --output "$XRANDR_OUTPUT" --rotate "$ORIENTATION"
}

function xinput-transform() {
  xinput set-prop "$XINPUT_DEVICE_NAME" "$XINPUT_TRANSFORM" $@
}

case $ORIENTATION in
normal)
  xrandr-rotate normal
  xinput-transform 1 0 0 0 1 0 0 0 1
  ;;
inverted)
  xrandr-rotate inverted
  xinput-transform -1 0 1 0 -1 1 0 0 1
  ;;
right)
  xrandr-rotate right
  xinput-transform 0 1 0 -1 0 1 0 0 1
  ;;
left)
  xrandr-rotate left
  xinput-transform 0 -1 1 1 0 0 0 0 1
  ;;
esac
