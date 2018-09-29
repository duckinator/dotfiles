# Default aliases. Common between Fish and Bash.

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
