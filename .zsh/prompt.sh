PROMPT=''
RPOMPT=''

function generate_prompt {
  # Specify colors to use.
  #
  # Possible color values (wrapped in $fg[ and ]):
  #   black  red
  #   green  yellow
  #   blue   magenta
  #   cyan   white
  #   bold
  #
  # Other possible values:
  #   $reset_color
  local NEUTRAL_COLOR="$fg[blue]"
  local DEFAULT_COLOR="$fg[magenta]"
  local ALERT_COLOR="$fg[red]"
  local PATH_COLOR=$NEUTRAL_COLOR
  local SYMBOL_COLOR=$DEFAULT_COLOR


  local USER_PREFIX=''
  local PROMPT_SYM_COLOR=''
  local PROMPT_SUFFIX=''

  if [ -n "$SSH_CONNECTION" ]; then
    # Set $USER_PREFIX to "user@host "
    USER_PREFIX="%{${NEUTRAL_COLOR}%}${USER}%{${SYMBOL_COLOR}%}@%{${NEUTRAL_COLOR}%}${HOST} "
  fi

  if [ "$UID" = "0" ]; then
    PROMPT_SYM_COLOR="${ALERT_COLOR}"
  else
    PROMPT_SYM_COLOR="${DEFAULT_COLOR}"
  fi

  if [ "$UID" = "0" ]; then
    # Root user
    PROMPT_SUFFIX='#'
  else
    # Non-root user
    PROMPT_SUFFIX='$'
  fi


  PROMPT="%{$terminfo[sgr0]$terminfo[bold]%}%{${PROMPT_SYM_COLOR}%}${USER_PREFIX}%{${PATH_COLOR}%}%30<..<%~%{$PROMPT_SYM_COLOR%}${REPO_INFO}%{$PROMPT_SYM_COLOR%}${PROMPT_SUFFIX}%{$terminfo[sgr0]%} "
  # Show exit code on the right side if it's not zero.
  RPROMPT="%{$terminfo[bold]%}%(?..%{${ALERT_COLOR}%}%?)%{$terminfo[sgr0]%}"
}

function precmd {
  # Terminal title, ran before the prompt is generated.
  case $TERM in
    *xterm*|*rxvt*|ansi) print -Pn "\e]2;%30<..<%~ | %y\a" # better for remote shells: "\e]2;%n@%m: %~\a"
      ;;
    screen) print -Pn "\e_ %30<..<%~ | %y\e\\" # better for remote shells: "\e_ %n@%m: %~\e\\"
      ;;
  esac
}

# After enter but before command
function preexec {
  local CMD="${1//\%/%%}"

  case $TERM in
    *xterm*|*rxvt*|ansi) print -nPR $'\e]0;'"${CMD} | %y"$'\a' # better for remote shells: "\e]2;%n@%m: $1\a"
      ;;
    screen) print -nPR $'\e_ '"${CMD} | %y"$'\e\\' # better for remote shells: "\e_ %n@%m: $1\e\\"
      ;;
  esac
}

generate_prompt
