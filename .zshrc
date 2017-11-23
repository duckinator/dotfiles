# vim: set ft=sh:

function zshload() {
  source "$HOME/.zsh/$1.sh"
}

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
zshload bind

# Make the prompt pretty.
autoload colors zsh/terminfo
colors

# Set some options that make zsh nicer.
setopt appendhistory autocd nomatch notify autolist automenu badpattern
setopt interactive_comments
# Don't beep on tab completion.
unsetopt beep complete_in_word

# Set the prompt.
zshload prompt

# Disable flow control.
stty -ixon -ixoff

zshload alias
zshload chruby
zshload dagd
zshload magic

if [[ "$(grep --version | head -n1)" =~ "\WGNU\W" ]]; then
  alias grep='grep --color=auto'
fi
