set SHELL fish
set UID (id -u)

if test -d "/var/run/user/$UID"
  export XDG_RUNTIME_DIR="/var/run/user/$UID"
end

set RUBY_PATHS
if test -d $HOME/.gem/ruby
  for dir in $HOME/.gem/ruby/*/bin
    set RUBY_PATHS "$dir/bin" $RUBY_PATHS
  end

  if test -d $HOME/.gem/ruby/bin
    set RUBY_PATHS "$HOME/.gem/ruby/bin" $RUBY_PATHS
  end
end

if test -f ~/.cargo/env
  source ~/.cargo/env
end

# Re: .npm-global: https://docs.npmjs.com/getting-started/fixing-npm-permissions
set -g PATH "$HOME/bin" "$HOME/.local/bin" "$HOME/.npm-global/bin" $RUBY_PATHS $PATH "/sbin" "/usr/sbin"
set -e RUBY_PATHS

if which nvim >/dev/null ^/dev/null
  export EDITOR=nvim
else if which vim >/dev/null ^/dev/null
  export EDITOR=vim
else
  export EDITOR=nano
end

export PAGER=less
export BROWSER=firefox

# -R: Allow ANSI escape codes by default. Needed for $RI below.
# -F: Automagically exit if the file fits on one screen.
# -X: Disables sending the termcap initialization and deinitialization strings
#     to the terminal, so as to avoid the crap where it clears the screen.
export LESS="-RFX"

# -f ansi: Use ANSI escape codes by default.
export RI="-f ansi"

source ~/.bash_env

touch ~/.env.fish.user
source ~/.env.fish.user
