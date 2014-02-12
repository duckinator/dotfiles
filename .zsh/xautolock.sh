if $(exists xautolock); then

if ! $(aliased xlock) && ! $(exists xlock) && ! $(aliased xunlock) && ! $(exists xunlock); then
	function xlock() {
		if [ -n "${DISPLAY}" ]; then
			__DISPLAY="${DISPLAY}"
		else
			__DISPLAY=":0.0"
		fi
		
		if [ -n "$2" ]; then
			__ARG="$2"
		else
			__ARG="-locknow"
		fi
		
		DISPLAY="${__DISPLAY}" xautolock $__ARG
		unset __ARG __DISPLAY
	}

	function xunlock() {
		xlock "$1" -unlocknow
	}
fi

if ! $(function_defined xneverlock) && ! $(aliased xneverlock) && ! $(exists xneverlock); then
    # Keep the screen from locking
    function xneverlock() {
      while true; do
        sleep 10
        xunlock
      done
    }
fi

fi
