# If not running interactively, don't do anything.
case $- in
    *i*) ;;
    *) return;;
esac

# Shell Options
# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s autocd checkjobs checkwinsize globstar histverify

# Source global definitions
[ -f /etc/bashrc            ] && . /etc/bashrc
[ -f "$HOME/.bash_aliases"  ] && . $HOME/.bash_aliases
[ -f "$HOME/.bash_env"      ] && . $HOME/.bash_env

# Creates a directory and then cd's to it.
function mkcd() {
    if [ "${#@}" -eq 0 ] || [ "${#@}" -ge 3 ]; then
        echo "Usage: mkcd [-p] dir"
        return 1
    fi

    if [ "$1" = "-p" ]; then
        mkdir -p "$2" && cd "$2"
    else
        mkdir "$1" && cd "$1"
    fi
}

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
    local fg_normal="\\[${FOREGROUND["reset"]}\\]"
    local fg_operator="\\[${FOREGROUND["brmagenta"]}\\]"
    local fg_user="\\[${FOREGROUND["blue"]}\\]"
    local fg_host="$fg_user"
    local fg_cwd="$fg_user"
    local bold="\\[${FOREGROUND["bold"]}\\]"
    local git_status
    local git_branch

    local prefix_hostname=""
    local prefix_venv=""
    local suffix_git=""
    local prompt_symbol="$"

    if test -n "$VIRTUAL_ENV"; then
        prefix_venv="(`basename \"$VIRTUAL_ENV\"`) "
    fi

    if test -n "$SSH_CONNECTION" || test -n "$PS1_SHOW_HOSTNAME"; then
        #prefix_hostname="${bold}${fg_user}\u${fg_operator}@${fg_host}\H${fg_operator}:"
        prefix_hostname="${bold}${fg_user}\u${fg_operator}@${fg_host}\h${fg_operator}:"
    fi

    if [ -z "$STATIC_PROMPT" ]; then
        git_status="$(git status -s 2>/dev/null)"
        if test $? -eq 0; then
            # If `git status` returns 0, this is a git repo, so show git information.
            git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"

            if test -n "$git_branch"; then
                suffix_git=" $git_branch"
            fi

            if test -n "$git_status"; then
                prompt_symbol="\\[${FOREGROUND["red"]}\\]+"
            else
                prompt_symbol="+"
            fi
        fi
    fi

    local prompt_main="${fg_cwd}\w${fg_operator}"
    export PS1="$bold$prefix_venv$prefix_hostname$prompt_main$suffix_git$prompt_symbol$fg_normal "
}

function post_cmd() {
    local LAST_STATUS=$?
    if [ $LAST_STATUS -gt 0 ]; then
        printf "%$[ $(tput cols) - ${#LAST_STATUS} - 2]s[$LAST_STATUS]\r"
    fi
}
export PROMPT_COMMAND="post_cmd; bash_prompt"


# The `|| true` is to avoid starting with a non-zero status code if there's
# no ~/.bashrc.local.
[ -f "$HOME/.bashrc.local" ] && source ~/.bashrc.local || true
