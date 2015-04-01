# TODO: Make this not barf in my $PATH
[ -d "/etc/profile.d/*.sh" ] && source /etc/profile.d/*.sh

tryppath $HOME/.bin

tryppath $HOME/.shell-utilities/bin
tryppath $HOME/.animation-utilities/bin

tryppath $HOME/.cabal/bin

tryppath $HOME/.npm-install/bin

tryppath /usr/local/heroku/bin

tryapath /opt/java/jre
tryapath /opt/java/jre/bin

tryapath $HOME/duxcc/bin
tryapath $HOME/duxcc/i386-elf
tryapath $HOME/duxcc/i386-elf/bin
tryapath $HOME/duxcc/i386-elf/lib

# For when using the GHC PPA. https://launchpad.net/~hvr/+archive/ubuntu/ghc
if [ -n "$(find /opt/ghc -maxdepth 1 2>/dev/null)" ]; then
  __GHC_VERSION=$(find /opt/ghc/ -maxdepth 1 | cut -d '/' -f 4 | sort -n | tail -n1)
  ppath "/opt/ghc/${__GHC_VERSION}/bin"
  unset __GHC_VERSION
fi

if [ -n "$(find $HOME/j64-*/bin)" ]; then
    for x in $HOME/j64-*/bin; do
        apath $x
    done
    unset x
fi

if [ -n "$(find $HOME/j32-*/bin)" ]; then
    for x in $HOME/j32-*/bin; do
        apath $x
    done
    unset x
fi

