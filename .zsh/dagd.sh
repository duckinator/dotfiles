# Aliases that use http://da.gd

if $(exists curl); then

function dagd() {
	__DAGD_POST=false
	__DAGD_URL="http://da.gd"
	__DAGD_ARGS="url_prefix=dagd%20&url_separator=%20&url_request_sep=%20--"
	for ((i=1; i<=${#@}; i++)); do
		__ARG="${@:$i:1}"
		if [ "${__ARG:0:2}" = "--" ]; then
			__DAGD_POST=true
			if [[ "${__ARG}" != *"="* ]]; then
				__ARG="${__ARG}=1"
			fi
			__DAGD_ARGS="${__DAGD_ARGS}&$(echo $__ARG | sed 's/^--//')"
		else
			__DAGD_URL="${__DAGD_URL}/${__ARG}"
		fi
	done
	
	if $__DAGD_POST; then
		curl --silent -L --data "${__DAGD_ARGS}" "${__DAGD_URL}"
	else
		curl --silent -L "${__DAGD_URL}?${__DAGD_ARGS}"
	fi
	
	unset __DAGD_URL
	unset __DAGD_ARGS
}

function das() {
	if [ -n "$1" ]; then
		echo $@ | das
	else
		curl -F 'url=<-' http://da.gd/shorten
	fi
}

alias dawho='dagd w'
alias daua='echo To find out the User Agent String of your browser, go to: http://da.gd/ua'
alias daip='dagd ip'
# TODO: Uncomment the following + remove das function above once /s works
#alias das='dagd s'

# TODO: Remove following line if/when CodeBlock moves /wp -> /wpe
alias dawpe='dagd wp'
# TODO: Uncomment following line if/when CodeBlock moves /wp -> /wpe and adds a
#+ /wp that loads the wp info
#alias dawp='dagd wp'
#alias dawpdesc='dagd wpdesc'

else # if $(exists ...)

function dagd() {
	echo "Please install curl and reload dagd.sh"
	echo "(closing and re-opening your terminal should suffice if you don't"
	echo " know how to reload dagd.sh)"
}

fi   # if $(exists ...)
