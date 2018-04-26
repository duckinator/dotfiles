# Default aliases. Common between Fish and Bash.

alias strip='python3 -c "import sys; print(sys.stdin.read().strip(), end=\"\")"'
alias copy='xclip -selection clipboard -i'
alias paste='xclip -selection clipboard -o'
alias scopy='strip | copy'
alias grep='grep --color=auto'
alias vim=nvim
