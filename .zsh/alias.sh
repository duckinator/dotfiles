# Aliases

## Miscellaneous

if $(which xclip &>/dev/null); then
  alias copy='xclip -selection clipboard -i'
  alias paste='xclip -selection clipboard -o'
fi

alias sshproxy='ssh -ND 9999'

alias drop-caches='echo 3 | sudo tee /proc/sys/vm/drop_caches'

alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"

## Incredibly complex "ls" alias

COLORAUTO=''
DIRSFIRST=''
INDICATOR_SLASH=''

# true if it runs, false otherwise
function runs() {
	$($@ &>/dev/null) && true
}

# Automagical coloring
# TODO: Find BSD equivalent
$(runs ls --color=auto)              && COLORAUTO='--color=auto'

# Put directories first in the list
# TODO: Find BSD equivalent
$(runs ls --group-directories-first) && DIRSFIRST='--group-directories-first'

# Use a slash suffix for indicating a file is a directory, same as
# --indicator-style=slash on GNU coreutils' ls
$(runs ls -p)   && INDICATOR_SLASH='-p'

unset -f runs

LS_ALIAS="ls $COLORAUTO $DIRSFIRST $INDICATOR_SLASH"
if [ "$LS_ALIAS" != "ls   " ]; then
  alias ls="$LS_ALIAS"
fi

unset COLORAUTO DIRSFIRST INDICATOR_SLASH LS_ALIAS
