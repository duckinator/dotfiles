# key bindings
bindkey "\e[1~" beginning-of-line  # Home
bindkey "\e[4~" end-of-line        # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history     # PageDown
bindkey "\e[2~" quoted-insert      # Insert
bindkey "\e[3~" delete-char        # Delete
bindkey "\e[5C" forward-word       # ?
bindkey "\eOc" emacs-forward-word  # ?
bindkey "\e[5D" backward-word      # ?
bindkey "\eOd" emacs-backward-word # ?
bindkey "\e\e[C" forward-word      # ?
bindkey "\e\e[D" backward-word     # ?
#bindkey "^H" backward-delete-word  # C-h

bindkey "^A" beginning-of-line # C-a
bindkey "^E" end-of-line       # C-e

# for rxvt
bindkey "\e[7~" beginning-of-line # ?
bindkey "\e[8~" end-of-line       # ?

# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line  # ?
bindkey "\eOF" end-of-line        # ?

# for freebsd console
bindkey "\e[H" beginning-of-line  # ?
bindkey "\e[F" end-of-line        # ?


# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix # C-i

bindkey "\e[A" history-search-backward # ?
bindkey "\e[B" history-search-forward  # ?
