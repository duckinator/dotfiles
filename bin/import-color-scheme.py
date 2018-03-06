#!/usr/bin/env python3

import sys
import os
import re

if len(sys.argv) == 1 or "--help" in sys.argv or "-h" in sys.argv:
    print("Usage: {} /path/to/color-scheme.txt".format(sys.argv[0]))
    sys.exit(1)

#def parse_ini(data):
#    lines = data.splitlines()
#
#    section = None
#    for line in lines:
#        if 


def file_exists(filename):
    if os.path.isdir(filename):
        print("Error: {} is a directory; expected a file.".format(filename))
        return False
    elif not os.path.isfile(filename):
        print("Error: {} does not exist.".format(filename))
        return False
    else:
        return True

def get_scheme_line(line):
    # If it's not specifying a color, ignore it.
    if len(line) == 0 or line[0] != "#":
        return None
    else:
        return re.split("\s+", line, 1)[::-1]

def get_scheme(filename):
    file_exists(filename) or sys.exit(1)

    with open(filename) as f:
        data = f.read()

    lines = data.splitlines()
    scheme = filter(None, map(get_scheme_line, lines))
    return dict(scheme)

def get_scheme_color(scheme, color):
    print(scheme[color])
    return scheme[color]

def get_xfce4_terminal_scheme(scheme):
    color_names = """
        Black
        Red
        Green
        Brown
        Blue
        Magenta
        Cyan
        Light Gray
        Dark Gray
        Light Red
        Light Green
        Yellow
        Light Blue
        Light Magenta
        Light Cyan
        White
    """.strip().splitlines()
    color_names = list(map(str.strip, color_names))
    colors = map(lambda c: get_scheme_color(scheme, c), color_names)

    parts = [
            "ColorPallette=" + ";".join(colors),
            "ColorForeground=" + get_scheme_color(scheme, "Foreground"),
            "ColorBackground=" + get_scheme_color(scheme, "Background")
            ]

    return 
    return "ColorPalette=" + ";".join(colors)
    #rgb(7,54,66);rgb(220,50,47);rgb(0,186,80);rgb(204,150,31);rgb(38,153,238);rgb(223,17,223);rgb(0,215,179);rgb(207,207,207);rgb(114,114,114);rgb(225,79,76);rgb(0,220,95);rgb(255,218,16);rgb(38,204,238);rgb(238,36,238);rgb(0,249,207);rgb(255,255,255)

scheme = get_scheme(sys.argv[1])
print(get_xfce4_terminal_scheme(scheme))
