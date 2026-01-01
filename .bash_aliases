# Default Bash aliases.

source "$HOME/.bash_demo_aliases"

alias last-se-log='ls -1 ~/.steam/debian-installation/steamapps/compatdata/244850/pfx/drive_c/users/steamuser/AppData/Roaming/SpaceEngineers/SpaceEngineers_*.log | sort | tail -n 1'

alias ansible-update-system='ansible-pull -K -U https://github.com/duckinator/system-config.git'
# Run nginx with both http & https using self-signed cert in current folder
alias nginx-here='podman run --rm -it -p 8080:80 -p 4443:443 -v "${PWD}:/srv/data" docker.io/rflathers/nginxserve'

alias rss='liferea'

alias sysinfo='konsole --workdir ~ --hide-menubar -e neowofetch --loop'

alias venv='if [ -n "$VIRTUAL_ENV" ]; then deactivate; else . venv/bin/activate; fi'

alias strstrip='python3 -c "import sys; print(sys.stdin.read().strip(), end=\"\")"'
alias copy='wl-copy'
alias paste='wl-paste'
alias scopy='strstrip | copy'
alias grep='grep --color=auto'

alias sshproxy='ssh -ND 9999'
alias drop-caches='echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias flush-swap='sudo bash -c "swapoff -a; swapon -a"'

alias b='bundle'
alias bi='bundle install'
alias be='bundle exec'

# A desperate attempt to make fluid work with a dark system theme.
# The colors could be better, but it works.
if which fluid &>/dev/null; then
    alias fluid='fluid -fg "#000000" -bg "#cccccc" -bg2 "#ccccdd" -scheme plastic'
fi

if which batcat &>/dev/null; then
    alias bat=batcat
fi

if which nvim &>/dev/null; then
  alias vim=nvim
fi


if [ -n "$DISABLE_FANCY_LS" ]; then
  # Do nothing.
  true
elif $(ls --version 2>/dev/null | grep -q GNU); then
  alias ls='ls -F --color=auto --group-directories-first'
elif [ "$(uname)" = "FreeBSD" ]; then
  # --color=auto only enables color on FreeBSD if $COLORTERM is set.
  alias ls='ls -F --color=auto'
else
  alias ls='ls -F'
fi
