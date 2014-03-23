# Aliases

alias back='cd $OLDPWD'
alias shred='shred -fuz'
alias home='cd ~ && clear'
alias sshproxy='ssh -ND 9999'

alias drop-caches='echo 3 | sudo tee /proc/sys/vm/drop_caches'

existalias rkhunter='sudo rkhunter -c'  rkhunter
existalias se='sudo $EDITOR'            sudo
existalias git='hub'                    hub
exists hub && compdef hub=git # Make tab completion be nice

existalias sprunge="curl -F 'sprunge=<-' http://sprunge.us" curl
existalias abssearch='ls -R /var/abs/ | grep' abs

existalias irb='ripl' ripl    # ripl > irb

# ls-specific aliases
runalias ll='ls -l'        ls -l
runalias la='ls -lA'       ls -lA
runalias lh='ls -lh'       ls -lh
runalias lah='ls -lAh'     ls -lAh


# Incredibly complex "ls" alias
COLORAUTO=''
DIRSFIRST=''
INDICATOR_SLASH=''

# Automagical coloring
# TODO: Find BSD equivalent
$(runs ls --color=auto)              && COLORAUTO='--color=auto'

# Put directories first in the list
# TODO: Find BSD equivalent
$(runs ls --group-directories-first) && DIRSFIRST='--group-directories-first'

# Use a slash suffix for indicating a file is a directory, same as
# --indicator-style=slash on GNU coreutils' ls
$(runs ls -p)   && INDICATOR_SLASH='-p'

LS_ALIAS="ls $COLORAUTO $DIRSFIRST $INDICATOR_SLASH"
if [ "$LS_ALIAS" != "ls   " ]; then
  alias ls="$LS_ALIAS"
fi

unset COLORAUTO DIRSFIRST INDICATOR_SLASH LS_ALIAS

# meminfo

MEMINFO_PROC="echo -e '/proc/meminfo:\n';grep --color=auto '^[Mem|Swap]*[Free|Total]*:' /proc/meminfo"
MEMINFO_FREE="echo 'free -m:'; free -m"
if [ -f "/proc/meminfo" ]; then
  if $(runs free); then
    alias meminfo="$MEMINFO_PROC && echo && $MEMINFO_FREE"
  else
    alias meminfo="$MEMINFO_PROC"
  fi
else
  existalias meminfo="$MEMINFO_FREE" free
fi

unset MEMINFO_PROC MEMINFO_FREE

