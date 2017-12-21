#!/bin/bash

XINPUT_TOUCHSCREEN_NAME="$(cat $HOME/.xinput-touchscreen-name)"

if [ -z "${XINPUT_TOUCHSCREEN_NAME}" ]; then
  echo "No touchscreen name specified!" >2
  exit 1
fi

ORIENTATION="$(qdbus --system net.hadess.SensorProxy /net/hadess/SensorProxy net.hadess.SensorProxy.AccelerometerOrientation)"

echo $ORIENTATION

if [ "$1" == "--check" ]; then
  # We only wanted to check the orientation, so exit.
  exit
fi

if [ "$1" == "--if-needed" ]; then
  if [ "$ORIENTATION" == "$1" ]; then
    exit
  fi
fi


XRANDR_OUTPUT="$(xrandr | grep "connected primary" | cut -d ' ' -f 1)"

XINPUT_TRANSFORM="Coordinate Transformation Matrix"

function xrandr-rotate() {
  xrandr --output "$XRANDR_OUTPUT" --rotate "$1"
}

function xinput-transform() {
  xinput set-prop "$XINPUT_TOUCHSCREEN_NAME" "$XINPUT_TRANSFORM" $@
}

case $ORIENTATION in
normal)
  xrandr-rotate normal
  xinput-transform 1 0 0 0 1 0 0 0 1
  ;;
bottom-up)
  xrandr-rotate inverted
  xinput-transform -1 0 1 0 -1 1 0 0 1
  ;;
right-up)
  xrandr-rotate right
  xinput-transform 0 1 0 -1 0 1 0 0 1
  ;;
left-up)
  xrandr-rotate left
  xinput-transform 0 -1 1 1 0 0 0 0 1
  ;;
esac
