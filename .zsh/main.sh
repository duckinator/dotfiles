DIR=$(dirname $(readlink -f $0)) # Directory script is in
_REMOTE=false

# Sets options for a remote (non-local system) prompt
function remote() {
	_REMOTE=true
}

# Loads file from ~/.zsh
function zshload() {
	varname="__ZSHLOAD_${1}"
	if [ "$(typeset ${varname} | cut -d'=' -f1)" != "true" ]; then
		export "${varname}=true"
		source $HOME/.zsh/$1.sh
	fi
	unset varname
}

function clean() {
	unset -f remote zshload clean
	unset DIR
}
