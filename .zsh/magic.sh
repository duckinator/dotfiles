function accept-line() {
	local tmp FILE

	if [[ $BUFFER == ,* ]]; then
		tmp=${BUFFER#,}
		BUFFER="mkdir $tmp && cd $tmp"
	elif [[ ${BUFFER:0:2} == ">>" ]]; then # Run Ruby code through Sicuro: >> CODE
		tmp=${BUFFER#>>}
		# Change ' to '\'' -- close the string, add an escape ', re-open the string.
		BUFFER="sicuro '${tmp//'/'\\''}'"
	fi

	zle .accept-line
}

zle -N accept-line
