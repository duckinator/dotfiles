# Default Bash aliases.

alias strstrip='python3 -c "import sys; print(sys.stdin.read().strip(), end=\"\")"'
alias copy='xclip -selection clipboard -i'
alias paste='xclip -selection clipboard -o'
alias scopy='strstrip | copy'
alias grep='grep --color=auto'

alias sshproxy='ssh -ND 9999'
alias drop-caches='echo 3 | sudo tee /proc/sys/vm/drop_caches'

alias b='bundle'
alias bi='bundle install'
alias be='bundle exec'


if which nvim &>/dev/null; then
  alias vim=nvim
fi


# -p is the same as --indicator-style=slash on GNU coreutils' `ls`.
if [ -n "$DISABLE_FANCY_LS" ]; then
  # Do nothing.
  true
elif $(ls --version 2>/dev/null | grep -q GNU); then
  alias ls='ls --color=auto --group-directories-first -p'
elif [ "$(uname)" = "FreeBSD" ]; then
  alias ls='ls -p -F -G'
else
  alias ls='ls -p'
fi

