#!/usr/bin/env python3

import os
from subprocess import check_call

try:
    # pip3
    from pip._internal import main as pip_main
except ImportError:
    # pip2
    from pip import main as pip_main

def run(fn, *args):
    print("$ {} {}".format(fn.__name__, " ".join(args)))
    result = fn(list(args))
    if result != 0:
        exit(result)

def emanate(args):
    import emanate
    return emanate.main(args)

def git(args):
    return check_call(["git", *args])

def pip(args):
    return pip_main(args)

def main():
    dotfiles_dir = os.path.dirname(__file__)
    os.chdir(dotfiles_dir)
    run(pip, "install", "emanate", "--user", "--no-cache-dir", "--quiet")
    #run(emanate, "--clean")
    run(git, "pull", "--quiet")
    run(emanate)

if __name__ == "__main__":
    main()
