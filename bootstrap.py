#!/usr/bin/env python3

import os
from pathlib import Path
from pip._internal import main as pip_main
import stat
import subprocess
import sys

dotfiles_dir = Path(Path.home(), "dotfiles")

def print_run(command):
    print("$ {}".format(" ".join(command)))

def run(command):
    print_run(command)
    results = subprocess.check_output(command, encoding="utf-8").strip()
    if len(results) > 0:
        print(results)

def git(*args):
    run(["git", *args])

def pip(*args):
    print_run(["pip", *args])
    pip_main([*args, "--user", "--no-cache-dir", "--quiet"])

def emanate(*args):
    import emanate
    print_run(["emanate", *args])
    emanate.main(args)

def main():
    os.chdir(dotfiles_dir)
    git("pull")
    pip("install", "emanate")
    #clean = "--clean-first" in sys.argv
    #if clean:
    #    emanate("--clean")
    emanate()

if __name__ == "__main__":
    main()
