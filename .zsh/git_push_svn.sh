function accept-line() {
	local tmp FILE

	if [[ $BUFFER == git\ push\ svn ]]; then
		tmp=${BUFFER#git push svn}
		BUFFER="git svn dcommit$tmp"
	fi

	zle .accept-line
}

zle -N accept-line
