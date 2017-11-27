# Creates a directory and then cd's to it.
function mkcd
  if test (count argv) -eq 0
    echo "Usage: mkcd [-p] dir"
  else
    set -l cd_args
    if test $argv[1] = "-p" 2>/dev/null
      set cd_args $argv[2]
    else
      set cd_args $argv[1]
    end

    mkdir $argv; and cd $cd_args
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

  set -l git_status (git status -s 2>/dev/null)
  if test $status -eq 0
    # If `git status` returns 0, this is a git repo, so show git information.
    set -l git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)

    if test -n "$git_branch"
      printf ' '$git_branch
    end

    if test -n "$git_status"
      set_color -o red
    end
    printf '+ '
  else
    # If `git status` returns anything else, it's not a git repo, so show the
    # normal prompt.
    printf '$ '
  end

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
