#!/usr/bin/env python3

import os
import subprocess
import time

touchscreen_name_file = os.environ["HOME"] + "/.auto-rotate--xinput-touchscreen-name.txt"
last_orientation_file = os.environ["HOME"] + "/.auto-rotate--hadess-sensor-proxy-last-orientation.txt"
can_rotate_file = os.environ["HOME"] + "/.auto-rotate--can-rotate.txt"


def read_file(filename):
    results = None
    with open(filename, "r") as f:
        results = f.read()
    return results


def write_file(filename, data):
    with open(filename, "w") as f:
        f.write(data)


def run(command):
    return subprocess.check_output(command, encoding="utf-8").strip()


def is_primary(line):
    return "connected primary" in line


def xrandr_output():
    return list(filter(is_primary, run(["xrandr"]).split("\n")))[0].split(" ")[0]


def xinput_touchscreen_name():
    # return read_file(touchscreen_name_file)
    return "11"


def xinput_transform_name():
    return "Coordinate Transformation Matrix"


def xrandr_rotate(rotation):
    print(run(["xrandr", "--output", xrandr_output(), "--rotate", rotation]))


def xinput_transform(*args):
    args_ = list(map(str, list(args)))
    print(run(["xinput", "set-prop", xinput_touchscreen_name(), xinput_transform_name(), *args_]))


def get_last_orientation():
    return read_file(last_orientation_file)


def get_new_orientation():
    return run("qdbus --system net.hadess.SensorProxy /net/hadess/SensorProxy net.hadess.SensorProxy.AccelerometerOrientation".split(" "))


def update_rotation():
    current_orientation = get_last_orientation()
    orientation = get_new_orientation()

    print('"' + current_orientation + '"')
    print('"' + orientation + '"')

    if current_orientation == orientation:
        return

    if orientation == "normal":
        xrandr_rotate("normal")
        xinput_transform(1, 0, 0, 0, 1, 0, 0, 0, 1)
    elif orientation == "bottom-up":
        xrandr_rotate("inverted")
        xinput_transform(-1, 0, 1, 0, -1, 1, 0, 0, 1)
    elif orientation == "right-up":
        xrandr_rotate("right")
        xinput_transform(0, 1, 0, -1, 0, 1, 0, 0, 1)
    elif orientation == "left-up":
        xrandr_rotate("left")
        xinput_transform(0, -1, 1, 1, 0, 0, 0, 0, 1)

    write_file(last_orientation_file, orientation)


while True:
    if xinput_touchscreen_name():  # and can_rotate():
        update_rotation()
    time.sleep(1)
