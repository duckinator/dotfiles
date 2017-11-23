[ -d "/var/run/user/$UID" ] && export XDG_RUNTIME_DIR=/var/run/user/$UID

# You can define $EDITOR, $GUI_EDITOR, $PAGER, and $BROWSER_CHOICES in ~/.zshenv.user,
#+ from most-preferred to your last choice.

[ -f "$HOME/.zshenv.user" ] && source $HOME/.zshenv.user

export EDITOR=vim
if ! $(which vim &>/dev/null); then
  export EDITOR=nano
fi

export PAGER=less
export BROWSER=firefox

# -R: Allow ANSI escape codes by default. Needed for $RI below.
# -F: Automagically exit if the file fits on one screen.
# -X: Disables sending the termcap initialization and deinitialization strings
#     to the terminal, so as to avoid the crap where it clears the screen.
export LESS="-RFX"

# -f ansi: Use ANSI escape codes by default.
export RI="-f ansi"
