#!/usr/bin/env python3

import os
from pathlib import Path
import subprocess
import sys

dotfiles_dir = Path(Path.home(), "dotfiles")
repo_url = "https://github.com/duckinator/dotfiles.git"

def run(command):
    results = subprocess.check_output(command, encoding="utf-8")
    print("    $ {}\n{}".format(" ".join(command), results))

def fetch_dotfiles():
    if not os.path.isdir(dotfiles_dir):
        run(["git", "clone", repo_url, dotfiles_dir])

def effuse():
    effuse_path = str(Path(Path.home(), "bin", "effuse"))
    os.chdir(dotfiles_dir)

    run(["gem", "install", "-r", "effuse"])
    run([effuse_path, "-c"])
    run(["git", "pull"])
    run([effuse_path])

def main():
    fetch_dotfiles()
    effuse()

if __name__ == "__main__":
    main()
