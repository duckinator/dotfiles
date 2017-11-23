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

if $(which xclip &>/dev/null); then
  alias copy='xclip -selection clipboard -i'
  alias paste='xclip -selection clipboard -o'
fi

alias sshproxy='ssh -ND 9999'
alias drop-caches='echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias open=xdg-open

# -p is the same as --indicator-style=slash on GNU coreutils' `ls`.
if [ ! $DISABLE_FANCY_LS ] && [ -n "$(ls --version | grep GNU)" ]; then
  alias ls='ls --color=auto --group-directories-first -p'
else
  alias ls='ls -p'
fi

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

if [ -f "/usr/local/share/chruby/chruby.sh" ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
elif [ -f "/usr/share/chruby/chruby.sh" ]; then
  source /usr/share/chruby/chruby.sh
  source /usr/share/chruby/auto.sh
fi

source ~/.zsh/prompt.sh

if [[ "$(grep --version | head -n1)" =~ "\WGNU\W" ]]; then
  alias grep='grep --color=auto'
fi


# Very magical things.
function accept-line() {
	local tmp

	if [[ $BUFFER == ,* ]]; then
		tmp=${BUFFER#,}
		BUFFER="mkcd ${(qq)tmp}"
	elif [[ "${${=BUFFER}[1]}" =~ ^[0-9]+.?[0-9]* ]]; then
		# Anything starting with a number followed by a space is treated as
		# code to be run by `dc`.
		BUFFER="dc -e ${(qq)BUFFER}' f'"
	elif [[ "${BUFFER:0:3}" == ">> " ]]; then
		# Anything starting with ">> " is treated as code to be run by Ruby.
		BUFFER="ruby -e ${(qq)${BUFFER#>> }}"
	fi

	zle .accept-line
}
zle -N accept-line
