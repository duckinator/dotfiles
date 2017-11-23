[ -d "/var/run/user/$UID" ] && export XDG_RUNTIME_DIR=/var/run/user/$UID

RUBY_PATHS=""
if [ -d $HOME/.gem/ruby ]; then
  for dir in $HOME/.gem/ruby/*; do
    RUBY_PATHS="$dir/bin:$RUBY_PATHS"
  done
fi

[ -f "$HOME/.cargo/env" ] && source $HOME/.cargo/env

# Re: .npm-global: https://docs.npmjs.com/getting-started/fixing-npm-permissions
export PATH="$HOME/bin:$HOME/go/bin:$HOME/.cabal/bin:$HOME/.npm-global/bin:$RUBY_PATHS:$PATH"
unset RUBY_PATHS

export EDITOR=vim
if ! $(which vim &>/dev/null); then
  export EDITOR=nano
fi

export PAGER=less
export BROWSER=firefox

# -R: Allow ANSI escape codes by default. Needed for $RI below.
# -F: Automagically exit if the file fits on one screen.
# -X: Disables sending the termcap initialization and deinitialization strings
#     to the terminal, so as to avoid the crap where it clears the screen.
export LESS="-RFX"

# -f ansi: Use ANSI escape codes by default.
export RI="-f ansi"

# You can override $EDITOR, $PAGER, and $BROWSER in ~/.zshenv.user.
[ -f "$HOME/.zshenv.user" ] && source $HOME/.zshenv.user
