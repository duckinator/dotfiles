# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f "$HOME/.bash_aliases" ]; then
  . $HOME/.bash_aliases
fi

if [ -f "$HOME/.bash_env" ]; then
  . $HOME/.bash_env
fi

if which nvim &>/dev/null; then
  alias vim=nvim
fi

declare -A FOREGROUND=(
  ["black"]="\033[30m"
  ["red"]="\033[31m"
  ["green"]="\033[32m"
  ["yellow"]="\033[33m"
  ["blue"]="\033[34m"
  ["magenta"]="\033[35m"
  ["cyan"]="\033[36m"
  ["white"]="\033[37m"

  ["brblack"]="\033[90m"
  ["brred"]="\033[91m"
  ["brgreen"]="\033[92m"
  ["bryellow"]="\033[93m"
  ["brblue"]="\033[94m"
  ["brmagenta"]="\033[95m"
  ["brcyan"]="\033[96m"
  ["brwhite"]="\033[97m"

  ["bold"]="\033[1m"
  ["reset"]="\033[0m"
)
function bash_prompt() {
  local prompt=""
  local fg_normal="\\[${FOREGROUND["reset"]}\\]"
  local fg_operator="\\[${FOREGROUND["brmagenta"]}\\]"
  local fg_user="\\[${FOREGROUND["blue"]}\\]"
  local fg_host="$fg_user"
  local fg_cwd="$fg_user"
  local bold="\\[${FOREGROUND["bold"]}\\]"
  local git_status
  local git_branch

  if test -n "$SSH_CONNECTION"; then
    prompt="${bold}${fg_user}\u${fg_operator}@${fg_host}\H${fg_operator}:"
  fi

  prompt="$prompt${fg_cwd}\w${fg_operator}"

  git_status="$(git status -s 2>/dev/null)"
  if test $? -eq 0; then
    # If `git status` returns 0, this is a git repo, so show git information.
    git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"

    if test -n "$git_branch"; then
      prompt="$prompt $git_branch"
    fi

    if test -n "$git_status"; then
      prompt="\\[${FOREGROUND["red"]}\\]"
    fi
    prompt="$prompt+ "
  else
    # If `git status` returns anything else, it's not a git repo, so show the
    # normal prompt.
    prompt="$prompt\$ "
  fi

  prompt="$prompt$fg_normal"
  export PS1="$prompt"
}

function post_cmd() {
  local LAST_STATUS=$?
  if [ $LAST_STATUS -gt 0 ]; then
    printf "%$[ $(tput cols) - ${#LAST_STATUS} - 2]s[$LAST_STATUS]\r"
  fi
}
export PROMPT_COMMAND="post_cmd; bash_prompt"
