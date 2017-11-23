# vim: set ft=sh:

function zshload() {
  source "$HOME/.zsh/$1.sh"
}

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

zshload completion
zshload bind

autoload colors zsh/terminfo
colors
source $HOME/.zsh/default.zshrc.colors

setopt appendhistory autocd nomatch notify autolist automenu badpattern
setopt interactive_comments
unsetopt beep complete_in_word

#zshload custom_colors
zshload prompt

# disable flow control
stty -ixon -ixoff

zshload functions
zshload alias

zshload chruby

zshload dagd

zshload magic

if [[ "$(grep --version | head -n1)" =~ "\WGNU\W" ]]; then
	alias grep='grep --color=auto'
fi

if [ ! -f "$HOME/.zshenv" ] || [ -n "${SSH_TTY}" ] || [ -n "${VNCDESKTOP}" ]; then
    zshload path
fi
zshload env

[ -f "$HOME/.zshrc.user" ] && source $HOME/.zshrc.user

[ -f "$HOME/.cargo/env" ] && source $HOME/.cargo/env
