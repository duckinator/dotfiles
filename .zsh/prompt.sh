function generate_prompt() {
  # Specify colors to use.
  #
  # Possible color values (wrapped in $fg[ and ]):
  #     black       red     green   yellow  blue
  #     megenta     cyan    white   bold
  #     $reset_color
  local NEUTRAL_COLOR="$fg[blue]"
  local ALERT_COLOR="$fg[red]"
  local SYMBOL_COLOR="$fg[magenta]"

  local USER_PREFIX=''

  if [ -n "$SSH_CONNECTION" ]; then
    # Set $USER_PREFIX to "user@host "
    USER_PREFIX="%{${NEUTRAL_COLOR}%}${USER}%{${SYMBOL_COLOR}%}@%{${NEUTRAL_COLOR}%}${HOST} "
  fi

  PROMPT="%{$terminfo[sgr0]${terminfo[bold]}${NEUTRAL_COLOR}%}${USER_PREFIX}%30<..<%~%{${SYMBOL_COLOR}%}$%{$terminfo[sgr0]%} "
  # Show exit code on the right side if it's not zero.
  RPROMPT="%{$terminfo[bold]%}%(?..%{${ALERT_COLOR}%}%?)%{$terminfo[sgr0]%}"
}

function precmd {
  # Terminal title, ran before the prompt is generated.
  case $TERM in
    *xterm*|*rxvt*|ansi) print -Pn "\e]2;%30<..<%~ | %y\a" # better for remote shells: "\e]2;%n@%m: %~\a"
      ;;
  esac
}

function preexec {
  # Terminal title, ran after enter but before command.
  local CMD="${1//\%/%%}"

  case $TERM in
    *xterm*|*rxvt*|ansi) print -nPR $'\e]0;'"${CMD} | %y"$'\a' # better for remote shells: "\e]2;%n@%m: $1\a"
      ;;
  esac
}

generate_prompt
