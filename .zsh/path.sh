# TODO: Make this not barf in my $PATH
[ -d "/etc/profile.d/*.sh" ] && source /etc/profile.d/*.sh

tryppath $HOME/.bin

tryppath $HOME/.shell-utilities/bin
tryppath $HOME/.animation-utilities/bin

tryppath $HOME/.cabal/bin

tryppath $HOME/.npm-install/bin

tryapath /opt/java/jre
tryapath /opt/java/jre/bin

tryapath $HOME/duxcc/bin
tryapath $HOME/duxcc/i386-elf
tryapath $HOME/duxcc/i386-elf/bin
tryapath $HOME/duxcc/i386-elf/lib

if [ -n "$(echo $HOME/j64-*/bin)" ]; then
    for x in $HOME/j64-*/bin; do
        apath $x
    done
    unset x
fi 2>/dev/null

if [ -n "$(echo $HOME/j32-*/bin)" ]; then
    for x in $HOME/j32-*/bin; do
        echo $x
        apath $x
    done
    unset x
fi 2>/dev/null

if [ -n "$(echo $HOME/.gem/*/*/bin)" ]; then
    for x in $HOME/.gem/*/*/bin; do
        apath $x
    done
    unset x
fi 2>/dev/null
