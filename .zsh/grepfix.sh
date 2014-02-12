if [[ "$(grep --version | head -n1)" =~ "\WGNU\W" ]]; then
	alias grep='grep --color=auto'
fi
