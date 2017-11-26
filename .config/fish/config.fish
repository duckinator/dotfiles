# Creates a directory and then cd's to it.
function mkcd
  if test -z "$1"
    echo "Usage:  $0 [-p] dir"
  else
    mkdir $argv
    if test "$1" = "-p"
      shift
    end
    cd $1
  end
end

if which xclip >/dev/null
  alias copy='xclip -selection clipboard -i'
  alias paste='xclip -selection clipboard -o'
end

alias sshproxy='ssh -ND 9999'
alias drop-caches='echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias ,=mkcd

function =
  echo $argv f | dc
end


# -p is the same as --indicator-style=slash on GNU coreutils' `ls`.
set GNU_GREP (ls --version | grep GNU)
if test -z "$DISABLE_FANCY_LS"
    and test -n "$GNU_GREP"
  alias ls='ls --color=auto --group-directories-first -p'
else
  alias ls='ls -p'
end
set -e GNU_GREP

set FISH_PROMPT_HOSTNAME (hostname)

set fish_color_normal       FFFFFF
set fish_color_autosuggestion 9C9C9C
set fish_color_command      $fish_color_normal
set fish_color_operator     brmagenta
set fish_color_user         blue
set fish_color_host         $fish_color_user
set fish_color_cwd          $fish_color_user
set fish_color_param        $fish_color_normal # *shrug* couldn't find something with good enoguh contrast.

function fish_prompt
  if test -n "$SSH_CONNECTION"
    set_color -o $fish_color_user
    printf $USER
    set_color -o $fish_color_operator
    printf @
    set_color -o $fish_color_user
    printf $FISH_PROMPT_HOSTNAME
    set_color -o $fish_color_operator
    printf :
  end

  set_color -o $fish_color_cwd
  printf (prompt_pwd)
  set_color -o $fish_color_operator
  printf '$ '
  set_color normal
end

function fish_right_prompt
  set -l _prompt_status $status
  if test $_prompt_status -ne 0
    set_color -o $fish_color_operator
    printf '['
    set_color -o red
    printf $_prompt_status
    set_color -o $fish_color_operator
    printf ']'
    set_color normal
  end
end

source ~/.config/fish/env.fish

if test -f ~/.config.fish.user
  source ~/.config.fish.user
end
