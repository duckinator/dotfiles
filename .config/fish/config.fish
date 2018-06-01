# Creates a directory and then cd's to it.
function mkcd
  if test (count $argv) -eq 0
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

function mkvenv
  if test -d venv
    echo "mkvenv: error: Directory ./venv already exists!"
    return 1
  else
    virtualenv venv --python=python3.6
  end
end

function =venv
  set -l search_dir
  if test (count $argv) -gt 0
    set search_dir $argv[1]
  else
    set search_dir .
  end

  set -l activate_file (find $search_dir -name 'activate.fish')

  if test -n "$VIRTUAL_ENV"
    echo "Already in a virtualenv ($VIRTUAL_ENV)"
  else if test -n "$activate_file"
    . "$activate_file"
    echo "In virtualenv $VIRTUAL_ENV."
    echo "Run `deactivate` to exit."
  else
    echo "No virtualenv directory found."
  end
end

function =tmux
  tmux -S ../tmux-(basename (pwd)) $argv
end

function demo
  if test -z "$DEMO_MODE"
    echo "Entering demo mode."
    echo
    set -g DEMO_MODE true
  else
    echo
    echo "Exiting demo mode."
    set -g DEMO_MODE false
  end
end

source $HOME/.bash_aliases

if locate nvim >/dev/null
  alias vim=nvim
end

function =
  echo $argv f | dc
end

function last-ss
  find ~/Pictures/Screenshots/ -type f | sort | tail -n 1
end

function boop-last
  boop file (last-ss) | scopy
  paste
end

# -p is the same as --indicator-style=slash on GNU coreutils' `ls`.
if test -n "$DISABLE_FANCY_LS"
  # Do nothing.
else if command ls --version ^/dev/null | grep GNU >/dev/null ^/dev/null
  alias ls='ls --color=auto --group-directories-first -p'
else if test (uname) = FreeBSD
  alias ls='ls -p -F -G'
else
  alias ls='ls -p'
end

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
  if test "$DEMO_MODE" = "true"
    set_color -o $fish_color_operator
    printf '$ '
    set_color -o $fish_color_normal
    return
  end

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

touch ~/.config.fish.user
source ~/.config.fish.user
