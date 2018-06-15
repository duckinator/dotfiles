#!/usr/bin/env python3

import os
from pip._internal import main as pip
from subprocess import check_call

def run(fn, args, name=None):
    print("$ {} {}".format(name or fn.__name__, " ".join(args)))
    return fn(args)

def git(args):
    return check_call(["git", *args])

def main():
    dotfiles_dir = os.path.dirname(__file__)
    os.chdir(dotfiles_dir)
    run("pip", ["install", "emanate", "--user", "--no-cache-dir"],
            fn=pip)
    import emanate

    #run("emanate", ["--clean"],
    #        fn=emanate.main)
    run(git, ["pull"])
    run(emanate.main, [],
            name="emanate")

if __name__ == "__main__":
    main()
