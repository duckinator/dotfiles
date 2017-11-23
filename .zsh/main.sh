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

# Append to $PATH
function apath() {
	export PATH=$PATH:$1
}

# Prepend to $PATH
function ppath() {
	export PATH=$1:$PATH
}

# Append to $PATH if it exists
function tryapath() {
	if [ -d "$@" ]; then
		apath "$@"
	fi
}

# Prepend to $PATH if it exists
function tryppath() {
	if [ -d "$@" ]; then
		ppath "$@"
	fi
}

# Load if it exists
function trysource() {
	if [ -f "$@" ]; then
		source "$@"
	fi
}

# true if it exists, false otherwise
function exists() {
	$(which $@ &>/dev/null) && true
}

# true if it runs, false otherwise
function runs() {
	$($@ &>/dev/null) && true
}

# Alias second arg to third arg, if first arg is in $PATH
function existalias() {
	# The following $(runs ...) could be:
	#   $(runs ${@:2})
	# but that came out in 4.3.11, netbsd has 4.3.10
	if $(exists $(bash $DIR/array-tail.sh $@)); then
		alias $1
	fi
}

# Alias second arg to third arg, if first arg is in $PATH and runs
function runalias() {
	# The following $(runs ...) could be:
	#   $(runs ${@:2})
	# but that came out in 4.3.11, netbsd has 4.3.10
	if $(runs $(bash $DIR/array-tail.sh $@)); then
		alias $1
	fi
}

function clean() {
	unset -f remote zshload apath ppath tryapath tryppath trysource runs exists existalias runalias clean
	unset DIR
}
