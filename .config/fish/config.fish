source $HOME/.config/fish/env.fish

function update-gem-home
  set -gx GEM_HOME (ruby -Ilib -r rubygems -e 'puts Gem.user_dir')
  set -gx GEM_PATH "/usr/share/gems:$GEM_HOME"
  set -gx PATH $PATH $GEM_HOME/bin
end

# Creates a directory and then cd's to it.
function mkcd
  if test '(' (count $argv) -eq 0 ')' -o '(' (count $argv) -ge 3 ')'
    echo "Usage: mkcd [-p] dir"
    return 1
  end

  mkdir $argv; and cd $argv[-1]
end

function =tmux
  tmux -S ../tmux-(basename (pwd)) $argv
end

function demo
  echo "Entering demo mode."
  echo
  env DEMO_MODE=true fish
  echo
  echo "Exiting demo mode."
end

source $HOME/.bash_aliases

if locate nvim >/dev/null
  alias vim=nvim
end

function =
  echo $argv f | dc
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

if test -f "$HOME/.config.fish.user"
  source "$HOME/.config.fish.user"
end
