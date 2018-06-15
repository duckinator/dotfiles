#!/usr/bin/env python3

import os
from pip._internal import main as pip
from subprocess import check_output
import sys

def run(fn, *args, name=None):
    print("$ {} {}".format(name or fn.__name__, " ".join(args)))
    results = fn(list(args))
    if isinstance(results, str):
        print(results, end='', flush=True)

def git(args):
    return check_output(["git", *args], encoding="utf-8")

def main():
    dotfiles_dir = os.path.dirname(__file__)
    os.chdir(dotfiles_dir)
    run(pip, "install", "emanate", "--user", "--no-cache-dir",
            name="pip")
    import emanate

    #run(emanate, "--clean")
    run(git, "pull")
    run(emanate.main,
            name="emanate")

if __name__ == "__main__":
    main()
