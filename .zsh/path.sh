# TODO: Make this not barf in my $PATH
[ -d "/etc/profile.d/*.sh" ] && source /etc/profile.d/*.sh

tryppath $HOME/bin

tryppath $HOME/go/bin

tryppath $HOME/.cabal/bin

# https://docs.npmjs.com/getting-started/fixing-npm-permissions
tryppath $HOME/.npm-global/bin

tryppath /usr/local/heroku/bin

if [ -d $HOME/.gem/ruby ]; then
  for dir in $HOME/.gem/ruby/*; do
    tryapath $dir/bin
  done
fi

# For when using the GHC PPA. https://launchpad.net/~hvr/+archive/ubuntu/ghc
if [ -n "$(find /opt/ghc -maxdepth 1 2>/dev/null)" ]; then
  __GHC_VERSION=$(find /opt/ghc/ -maxdepth 1 | cut -d '/' -f 4 | sort -n | tail -n1)
  ppath "/opt/ghc/${__GHC_VERSION}/bin"
  unset __GHC_VERSION
fi

