# You can define $EDITOR, $GUI_EDITOR, $PAGER, and $BROWSER_CHOICES in ~/.zshenv.user,
#+ from most-preferred to your last choice.

[ -f "$HOME/.zshenv.user" ] && source $HOME/.zshenv.user

# Defaults
[ -z "$EDITOR_CHOICES"     ] && EDITOR_CHOICES=(vim nano)
[ -z "$GUI_EDITOR_CHOICES" ] && GUI_EDITOR_CHOICES=(gedit geany gvim)
[ -z "$PAGER_CHOICES"      ] && PAGER_CHOICES=(less more most)
[ -z "$BROWSER_CHOICES"    ] && BROWSER_CHOICES=(opera firefox chromium-browser chrome midori chromium) # Chromium is last because sometimes it's a game.

# -R: Allow ANSI escape codes by default. Needed for $RI below.
# -F: Automagically exit if the file fits on one screen.
# -X: Disables sending the termcap initialization and deinitialization strings
#     to the terminal, so as to avoid the crap where it clears the screen.
export LESS="-RFX"

# -f ansi: Use ANSI escape codes by default.
export RI="-f ansi"

# Make RHEL, CentOS, and NetBSD(?) behave themselves.
# Run `touch ~/.zsh-is-old-as-crap` to use this.
# TODO: Make this less hacky.
if [ ! -f "~/.zsh-is-old-as-crap" ]; then

# Yes, this is painfully repetitive.
# I'm working on a way to fix that...

if [ -z "$EDITOR" ]; then
	for ((i=0;i<${#EDITOR_CHOICES};i++)); do
		if $(exists ${EDITOR_CHOICES:$i:1}); then
			export EDITOR=${EDITOR_CHOICES:$i:1}
			break
		fi
	done
fi

if [ -z "$GUI_EDITOR" ]; then
	for ((i=0;i<${#GUI_EDITOR_CHOICES};i++)); do
		if $(exists ${GUI_EDITOR_CHOICES:$i:1}); then
			export GUI_EDITOR=${GUI_EDITOR_CHOICES:$i:1}
			break
		fi
	done
fi

if [ -z "$PAGER" ]; then
	for ((i=0;i<${#PAGER_CHOICES};i++)); do
		if $(exists ${PAGER_CHOICES:$i:1}); then
			export PAGER=${PAGER_CHOICES:$i:1}
			break
		fi
	done
fi

if [ -n "$DISPLAY" ] && [ -z "$BROWSER" ]; then
	for ((i=0;i<${#BROWSER_CHOICES};i++)); do
		if $(exists ${BROWSER_CHOICES:$i:1}); then
			export BROWSER=${BROWSER_CHOICES:$i:1}
			break
		fi
	done
fi


fi

