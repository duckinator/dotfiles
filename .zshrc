# vim: set ft=sh:

# Creates a directory and then cd's to it.
mkcd() {
  if [ -z "$1" ]; then
    echo "Usage:  $0 [-p] dir"
  else
    mkdir $@
    [ "$1" = "-p" ] && shift
    cd $1
  fi
}

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Autocompletion
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle :compinstall filename "/home/$USER/.zshrc"
autoload -Uz compinit
compinit

# Key bindings.
source ~/.zsh/bind.sh

# Make the prompt pretty.
autoload colors zsh/terminfo
colors

# Set some options that make zsh nicer.
setopt appendhistory autocd nomatch notify autolist automenu badpattern
setopt interactive_comments
# Don't beep on tab completion.
unsetopt beep complete_in_word

# Disable flow control.
stty -ixon -ixoff

for x in alias chruby dagd magic prompt; do
  source ~/.zsh/$x.sh
done

if [[ "$(grep --version | head -n1)" =~ "\WGNU\W" ]]; then
  alias grep='grep --color=auto'
fi
