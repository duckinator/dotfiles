#!/usr/bin/env python3

import os
import subprocess
import sys

home_dir = os.environ["HOME"]
dotfiles_dir = os.path.join(home_dir, "dotfiles")
clone_command = [
    "git", "clone", "https://github.com/duckinator/dotfiles.git", dotfiles_dir
]

if not os.path.isdir(dotfiles_dir):
    os.chdir(home_dir)
    results = subprocess.check_output(clone_command, encoding="utf-8")

os.chdir(dotfiles_dir)

def run(cmd):
    return "[{}] $ {}\n{}".format(
            sys.argv[0],
            cmd,
            subprocess.check_output(cmd.split(), encoding="utf-8"))

print(run("gem install -r effuse"))
print(run("effuse -c"))
print(run("git pull"))
print(run("effuse"))
