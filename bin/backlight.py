#!/usr/bin/env python3

import sys
from subprocess import check_call

num_displays = 2

def backlight_set(level):
    # sudo ddcutil --display 1 setvcp 10 50
    for display in range(1, num_displays + 1):
        check_call(["sudo", "ddcutil", "--display", str(display), "setvcp", "10", str(level)])


def backlight_get():
    # sudo ddcutil --display 1 getvcp 10 50
    for display in range(1, num_displays + 1):
        results = check_call(["ddcutil", "--display", str(display), "getvcp", "10"])
        print(results)


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

    #cur_, max_ = backlight_get()
    #min_ = 1
    #if len(argv) < 2:
    #    print("{} / {}".format(cur_, max_))
    #    return 0

    #brightness = backlight_calc(cur_, min_, max_, argv[1])

    #print(brightness)
    brightness = argv[1]
    backlight_set(brightness)

    return 0


if __name__ == "__main__":
    exit(main())
