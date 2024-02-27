# Default Bash aliases.

source "$HOME/.bash_demo_aliases"

alias rss='liferea'

alias sysinfo='konsole --workdir ~ --hide-menubar -e neofetch --loop'

alias venv='if [ -n "$VIRTUAL_ENV" ]; then deactivate; else . venv/bin/activate; fi'

alias strstrip='python3 -c "import sys; print(sys.stdin.read().strip(), end=\"\")"'
alias copy='xclip -selection clipboard -i'
alias paste='xclip -selection clipboard -o'
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
