#!/usr/bin/env python3

import os
from pip._internal import main as pip
from subprocess import check_call

def run(fn, *args, name):
    print("$ {} {}".format(name, " ".join(args)))
    return fn(list(args))

def git(args):
    return check_call(["git", *args])

def main():
    dotfiles_dir = os.path.dirname(__file__)
    os.chdir(dotfiles_dir)
    run(pip, "install", "emanate", "--user", "--no-cache-dir",
            name="pip")
    import emanate

    #run(emanate.main, "--clean",
    #        name="emanate")
    run(git, "pull",
            name="git")
    run(emanate.main,
            name="emanate")

if __name__ == "__main__":
    main()
