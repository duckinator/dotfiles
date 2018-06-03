#!/usr/bin/env python3

import importlib
import os
from pathlib import Path
import stat
import subprocess
import sys
from urllib.request import urlopen as get

dotfiles_dir = Path(Path.home(), "dotfiles")
repo_url = "https://github.com/duckinator/dotfiles.git"
emanate_file = Path("./bin/dotfiles_emanate.py")

def download_emanate():
    raw_contents = get("https://raw.githubusercontent.com/duckinator/emanate/master/emanate/__init__.py").read()
    code = str(raw_contents, encoding="utf-8")
    emanate_file.write_text(code)
    emanate_file.chmod(emanate_file.stat().st_mode | stat.S_IEXEC)

def run(command):
    results = subprocess.check_output(command, encoding="utf-8").strip()
    if len(results) > 0:
        print(results)

def fetch_dotfiles():
    if not os.path.isdir(dotfiles_dir):
        run(["git", "clone", repo_url, dotfiles_dir])

def main():
    fetch_dotfiles()
    os.chdir(dotfiles_dir)
    download_emanate()
    importlib.import_module("dotfiles_emanate").main()

if __name__ == "__main__":
    main()
