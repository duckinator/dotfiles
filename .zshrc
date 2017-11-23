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

if [[ "$(grep --version | head -n1)" =~ "\WGNU\W" ]]; then
  alias grep='grep --color=auto'
fi


### BEGIN KEY BINDINGS ###

bindkey "\e[1~" beginning-of-line  # Home
bindkey "\e[4~" end-of-line        # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history     # PageDown
bindkey "\e[2~" quoted-insert      # Insert
bindkey "\e[3~" delete-char        # Delete
bindkey "\e[5C" forward-word       # ?
bindkey "\eOc" emacs-forward-word  # ?
bindkey "\e[5D" backward-word      # ?
bindkey "\eOd" emacs-backward-word # ?
bindkey "\e\e[C" forward-word      # ?
bindkey "\e\e[D" backward-word     # ?
#bindkey "^H" backward-delete-word  # C-h

bindkey "^A" beginning-of-line # C-a
bindkey "^E" end-of-line       # C-e

# for rxvt
bindkey "\e[7~" beginning-of-line # ?
bindkey "\e[8~" end-of-line       # ?

# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line  # ?
bindkey "\eOF" end-of-line        # ?

# for freebsd console
bindkey "\e[H" beginning-of-line  # ?
bindkey "\e[F" end-of-line        # ?

### END KEY BINDINGS ###


# Completion in the middle of a line.
bindkey '^i' expand-or-complete-prefix # C-i

bindkey "\e[A" history-search-backward # ?
bindkey "\e[B" history-search-forward  # ?

### BEGIN PROMPT ###
function generate_prompt() {
  # Possible color values (wrapped in $fg[ and ]):
  #     black       red     green   yellow  blue
  #     megenta     cyan    white   bold
  #     $reset_color
  local NEUTRAL_COLOR="$fg[blue]"
  local ALERT_COLOR="$fg[red]"
  local SYMBOL_COLOR="$fg[magenta]"

  if [ -n "$SSH_CONNECTION" ]; then
    # Set $USER_PREFIX to "user@host "
    local USER_PREFIX="%{${NEUTRAL_COLOR}%}${USER}%{${SYMBOL_COLOR}%}@%{${NEUTRAL_COLOR}%}${HOST} "
  fi

  PROMPT="%{$terminfo[sgr0]${terminfo[bold]}${NEUTRAL_COLOR}%}${USER_PREFIX}%30<..<%~%{${SYMBOL_COLOR}%}$%{$terminfo[sgr0]%} "
  # Show exit code on the right side if it's not zero.
  RPROMPT="%{$terminfo[bold]%}%(?..%{${ALERT_COLOR}%}%?)%{$terminfo[sgr0]%}"
}

if [[ "$TERM" =~ ".*xterm.*|.*rxvt.*|ansi" ]]; then
  function precmd {
    # Terminal title, ran before the prompt is generated.
    print -Pn "\e]2;%30<..<%~ | %y\a" # better for remote shells: "\e]2;%n@%m: %~\a"
  }

  function preexec {
    # Terminal title, ran after enter but before command.
    local CMD="${1//\%/%%}"

    print -nPR $'\e]0;'"${CMD} | %y"$'\a' # better for remote shells: "\e]2;%n@%m: $1\a"
  }
fi

generate_prompt

### END PROMPT ###


if [ ! -n "$ZSH_NO_MAGIC" ]; then

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
fi
