# Stolen from http://da.gd/lazyJSON
function -lazyJSON {
	print -r -- $(grep -Po "(?<=\"$1\":\")(\\\\.|[^\"])+" <<< $response)
}

function accept-line() {
	local tmp FILE

	if [[ $BUFFER == ,* ]]; then
		tmp=${BUFFER#,}
		BUFFER="mkcd ${(qq)tmp}"
	elif [[ ${BUFFER:0:2} == ">>" ]]; then # Run Ruby code through Sicuro: >> CODE
		tmp=${BUFFER#>>}
		BUFFER="sicuro ${(qq)tmp}"
	elif [[ "${${=BUFFER}[1]}" =~ [0-9]+.?[0-9]* ]]; then
		BUFFER="dc -e ${(qq)BUFFER}' f'"
	#elif [[ "${${=BUFFER}[1]}" =~ ![^>]*>> ]]; then
		# !X>> where X is the Ruby version.
		#...
	elif [[ "${${=BUFFER}[1]}" =~ \!([^\>]+)\>[\s]*(.*) ]]; then
		language=${${BUFFER%>*}:1}
		code=${BUFFER#*>}
		echo
		request='{"language":'"${(qqq)language}"',"code":'"${(qqq)code}"'}'
		command="curl -sS -d ${(qq)request} http://beta.eval.so/api/evaluate"
		response=$(eval $command)
		stderr=$(-lazyJSON stderr)
		stdout=$(-lazyJSON stdout)

		if [[ -n "$stderr" ]]; then
			echo "STDERR:"
			echo $stderr
		fi
		echo "STDOUT:"
		echo -n $(-lazyJSON stdout)
		BUFFER=""
	fi

	zle .accept-line
}

zle -N accept-line
