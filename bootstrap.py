#!/usr/bin/env python3

import os
from pathlib import Path
from pip._internal import main as pip
import stat
import subprocess
import sys

dotfiles_dir = Path(Path.home(), "dotfiles")

def run(command):
    print("$ {}".format(" ".join(command)))
    results = subprocess.check_output(command, encoding="utf-8").strip()
    if len(results) > 0:
        print(results)

def fetch_dotfiles():
    if not os.path.isdir(dotfiles_dir):
        run(["git", "clone", repo_url, dotfiles_dir])

def emanate(*args):
    run([str(Path.home() / ".local" / "bin" / "emanate"), *args])

def main():
    fetch_dotfiles()
    os.chdir(dotfiles_dir)
    run(["git", "pull"])
    pip(["install", "emanate", "--user", "--no-cache-dir"])
    import emanate
    clean = "--clean-first" in sys.argv
    #if clean:
    #    emanate("--clean")
    print("Running Emanate...")
    emanate.main()
    print("Done.")

if __name__ == "__main__":
    main()
