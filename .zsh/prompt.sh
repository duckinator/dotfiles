PROMPT=''
RPOMPT=''

function generate_prompt {
	generate_todo_prompt

	local SHOW_DYNAMIC_PROMPT=true
	local REPO_INFO=''
	local REPO_DIRTY=''
	local REPO_DETACHED=''
	local REPO_BRANCH=''
	local REPO_BRANCH_STATUS=''
	local RELATION_TO_MASTER=''
	local PROMPT_PREFIX=''
	      PROMPT_SEPARATOR=' '
	local RELATION_TO_MASTER=''
	local DIRTY=''
	local USER_PREFIX=''
	local PROMPT_SYM_COLOR=''
	local PROMPT_SUFFIX=''

	if $_REMOTE; then
		# Set $USER_PREFIX to "user@host "
		USER_PREFIX="%{${NEUTRAL_COLOR}%}${USER}%{${SYMBOL_COLOR}%}@%{${NEUTRAL_COLOR}%}${HOST} "
	fi

	if [ "$UID" = "0" ]; then
		PROMPT_SYM_COLOR="${ALERT_COLOR}"
	else
		PROMPT_SYM_COLOR="${DEFAULT_COLOR}"
	fi

	if $_ZSH_DYNAMIC_PROMPT; then
		local git_status="$(git status 2>/dev/null)"

		if [ -d ".hg" ]; then
			[ -z "$(hg diff 2>/dev/null)" ] || _REPO_DIRTY='⚡'
			REPO_BRANCH="$(hg branch 2>/dev/null)"
			PROMPT_SUFFIX='☿'
		elif [ -n "$git_status" ]; then
			local st="$git_status"
			if [ -n "$st" ]; then
				local -a arr
				arr=(${(f)st})

				# As far as I know, no-branch is only triggered by entering a detached
				# head state on older versions of git.
				if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
					REPO_BRANCH='no-branch'
				elif [[ $arr[1] =~ 'HEAD detached at' ]]; then
					REPO_BRANCH="${arr[1][(w)5]}"
					REPO_DETACHED="¦"
				else
					REPO_BRANCH="${arr[1][(w)4]}";
				fi

				if [[ $arr[2] =~ 'Your branch is' ]]; then
					if [[ $arr[2] =~ 'ahead' ]]; then
						RELATION_TO_MASTER="↑" # Branch is ahead of master
					elif [[ $arr[2] =~ 'diverged' ]]; then
						RELATION_TO_MASTER="↕" # Branch is diverged from master
					elif [[ $arr[2] =~ 'behind' ]]; then
						RELATION_TO_MASTER="↓" # Branch is behind master
					fi
				fi

				# Repo is dirty.
				[[ $st =~ 'nothing to commit' ]] || PROMPT_SEPARATOR="%{${ALERT_COLOR}%}⚡%{$PROMPT_SYM_COLOR%}"
				if [ -n "${_REPO_DETACHED}" ]; then
					local tmp="${PROMPT_SEPARATOR}"
					if [[ "${PROMPT_SEPARATOR}" == " " ]]; then
						tmp=""
					fi
					PROMPT_SEPARATOR="${tmp}%{${ALERT_COLOR}%}${REPO_DETACHED}"
				fi
			fi
			REPO_INFO="${PROMPT_SEPARATOR}%{${BRANCH_COLOR}%}${REPO_BRANCH}%{${SYMBOL_COLOR}%}${RELATION_TO_MASTER}"
			PROMPT_SUFFIX="+"
		else
			SHOW_DYNAMIC_PROMPT=false
		fi
	else
		SHOW_DYNAMIC_PROMPT=false
	fi
	
	if $SHOW_DYNAMIC_PROMPT; then
		echo -n; # Do nothing
	elif [ "$UID" = "0" ]; then
		# Generic, root user
		PROMPT_SUFFIX='#'
	else
		# Generic, non-root user
		PROMPT_SUFFIX='$'
	fi

	local TODO_PROMPT_TEXT="%{${terminfo[bold]}${ALERT_COLOR}%}${_ZSH_TODO_PROMPT_TEXT}"

	EXIT_CODE="%{$terminfo[bold]%}%(?..%{${ALERT_COLOR}%}%?)${TODO_PROMPT_TEXT}%{$terminfo[sgr0]%}"

	PROMPT="%{$terminfo[sgr0]$terminfo[bold]%}${PROMPT_PREFIX}%{${PROMPT_SYM_COLOR}%}${USER_PREFIX}%{${PATH_COLOR}%}%30<..<%~%{$PROMPT_SYM_COLOR%}${REPO_INFO}%{$PROMPT_SYM_COLOR%}${PROMPT_SUFFIX}%{$terminfo[sgr0]%} "
	RPROMPT="${EXIT_CODE}"
}

function generate_todo_prompt {
	if $_ZSH_TODO_PROMPT; then
		if [ -n "$__ZSH_TODO_EXEC" ] && [ -n "$(bash -c $__ZSH_TODO_EXEC)" ]; then
			_ZSH_TODO_PROMPT_TEXT=" ✔"
		else
			_ZSH_TODO_PROMPT_TEXT=""
		fi
	fi
}

function print_terminal_title {
	generate_todo_prompt

	case $TERM in
		*xterm*|*rxvt*|ansi) print -Pn "\e]2;%30<..<%~ | %y${_ZSH_TODO_PROMPT_TEXT}\a" # better for remote shells: "\e]2;%n@%m: %~\a"
		;;
		# FIXME: $_ZSH_TODO_PROMPT_TEXT never seems to be set correctly, here.
		#    The rest works fine, however, so I'm not sure what's going on.
		screen) print -Pn "\e_ %30<..<%~ | %y${_ZSH_TODO_PROMPT_TEXT}\e\\" # better for remote shells: "\e_ %n@%m: %~\e\\"
		;;
	esac
}

function chpwd {
	# TODO: Figure out if there's any case where this actually does anything
	#   besides merely slow down execution. With some quick poking around,
	#   I couldn't find any, since it's a subset of what's done in precmd.
	#print_terminal_title
}

# Before prompt
function precmd {
	generate_prompt

	print_terminal_title
}

# After enter but before command
function preexec {
	local CMD="${1//\%/%%}"

	case $TERM in
		*xterm*|*rxvt*|ansi) print -nPR $'\e]0;'"${CMD} | %y${_ZSH_TODO_PROMPT_TEXT}"$'\a' # better for remote shells: "\e]2;%n@%m: $1\a"
		;;
		screen) print -nPR $'\e_ '"${CMD} | %y${_ZSH_TODO_PROMPT_TEXT}"$'\e\\' # better for remote shells: "\e_ %n@%m: $1\e\\"
		;;
	esac
}

chpwd # So it sets the prompt initially
