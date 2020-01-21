#!/usr/bin/env python3

import sys

device = "nv_backlight"
device_path = "/sys/class/backlight/" + device


def backlight_set(file_path, level):
    with open(file_path, "w") as f:
        f.write(str(level))


def backlight_get(file_path):
    with open(file_path) as f:
        return int(f.read())


def backlight_calc(current, min_, max_, string):
    adjustment = int(string)

    if string[0] in ["-", "+"]:
        result = current + adjustment
    else:
        result = adjustment

    return min(max(min_, result), max_)


def main(argv=None):
    if argv is None:
        argv = sys.argv

    cur_file = device_path + "/brightness"
    max_file = device_path + "/max_brightness"

    cur_ = backlight_get(cur_file)
    min_ = 1
    max_ = backlight_get(max_file)
    if len(argv) < 2:
        print("{} / {}".format(cur_, max_))
        return 0

    brightness = backlight_calc(cur_, min_, max_, argv[1])

    print(brightness)
    backlight_set(cur_file, brightness)

    return 0


if __name__ == "__main__":
    exit(main())
