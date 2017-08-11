# Stolen from http://da.gd/lazyJSON
function -lazyJSON {
	print -r -- $(grep -Po "(?<=\"$2\":\")(\\\\.|[^\"])+" <<< "$1")
}

function accept-line() {
	local tmp FILE

	if [[ $BUFFER == ,* ]]; then
		tmp=${BUFFER#,}
		BUFFER="mkcd ${(qq)tmp}"
	elif [[ "${${=BUFFER}[1]}" =~ [0-9]+.?[0-9]* ]]; then
		# Anything starting with a number followed by a space is treated as
		# code to be run by `dc`.
		BUFFER="dc -e ${(qq)BUFFER}' f'"
	elif [[ "${BUFFER:0:2}" == ">>" ]]; then
		# Anything starting with ">> " is treated as code to be run by Ruby.
		BUFFER="ruby -e ${(qq)${BUFFER#>>}}"
	fi

	zle .accept-line
}

zle -N accept-line
