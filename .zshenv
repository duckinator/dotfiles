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

source $HOME/.zsh/env.sh
