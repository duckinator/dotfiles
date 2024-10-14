#!/usr/bin/env python3

import sys
from subprocess import check_call, run, PIPE

def num_displays():
    results = run(["ddcutil", "detect", "-t"], stdout=PIPE, check=True)
    chunks = results.stdout.decode().strip().split("\n\n")
    return len(chunks)

def backlight_set(level):
    # sudo ddcutil --display 1 setvcp 10 50
    for display in range(1, num_displays() + 1):
        check_call(["sudo", "ddcutil", "--display", str(display), "setvcp", "10", str(level)])


def backlight_get():
    # sudo ddcutil --display 1 getvcp 10 50
    results = []
    for display in range(1, num_displays() + 1):
        # b'VCP code 0x10 (Brightness                    ): current value =    30, max value =   100\n'
        run_results = run(["ddcutil", "--display", str(display), "getvcp", "10"], stdout=PIPE, check=True)
        stdout = run_results.stdout.decode()
        left, right = stdout.split(":")

        # VCP code 0x10 (Brightness                    )
        code = left.split(" ")[2].strip()
        name = left.split("(")[1].split(")")[0].strip()

        # current value =    30, max value =   100
        metadata = {}
        for part in right.split(","):
            key, val = [x.strip() for x in part.split("=")]
            key = key.replace(" value", "")
            metadata[key] = val

        if "current" in metadata:
            metadata["current"] = int(metadata["current"])

        if "max" in metadata:
            metadata["max"] = int(metadata["max"])

        brightness = int(metadata["current"] * 100 / metadata["max"])

        results.append({
            "id": display,
            "code": code,
            "name": name.lower(),
            "brightness_percent": brightness,
            **metadata
        })
    return results

def print_display_brightness():
    for display in backlight_get():
        print(f"Brightness (display {display['id']}): {display['brightness_percent']}% ({display['current']} / {display['max']})")

def backlight_calc(string):
    adjustment = int(string)
    backlight = backlight_get()[0]
    current = backlight["brightness_percent"]
    max_ = backlight["max"]

    if string[0] in ["-", "+"]:
        result = current + adjustment
    else:
        result = int(adjustment * 100 / max_)

    percent = min(max(0, result), 100)

    absolute = int(percent * max_ / 100)

    return absolute

def print_help():
    print("Usage: backlight.py BRIGHTNESS_PERCENT")
    print("       backlight.py +PERCENT")
    print("       backlight.py -PERCENT")

def main(argv=None):
    if argv is None:
        argv = sys.argv

    num_args = len(argv) - 1

    if "-h" in argv or "--help" in argv:
        print_help()
        return 1

    match num_args:
        case 0:
            print_display_brightness()
        case 1:
            absolute = backlight_calc(argv[1])
            backlight_set(absolute)
            print_display_brightness()
        case _:
            print_help()
            return 1

    return 0


if __name__ == "__main__":
    exit(main())
