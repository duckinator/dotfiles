#!/usr/bin/env python3

import os
import subprocess
from pathlib import Path

dotfiles_dir = Path(Path.home(), "dotfiles")
repo_url = "https://github.com/duckinator/dotfiles.git"

def run(command):
    results = subprocess.check_output(command, encoding="utf-8")
    print("    $ {}\n{}".format(" ".join(command), results))

if not os.path.isdir(dotfiles_dir):
    run(["git", "clone", repo_url, dotfiles_dir])

os.chdir(dotfiles_dir)

run(["gem", "install", "-r", "effuse"])
run(["effuse", "-c"])
run(["git", "pull"])
run(["effuse"])
