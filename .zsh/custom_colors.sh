# Possible color values (wrapped in $fg[ and ]):
#   black  red
#   green  yellow
#   blue   magenta
#   cyan   white
#   bold
#
# Other possible values:
#   $reset_color

# Load default colors from ./default.zshrc.colors
source $HOME/.zsh/default.zshrc.colors

# Load overridden colors from ~/.zshrc.colors, if it exists.
[ -f "$HOME/.zshrc.colors" ] && source ~/.zshrc.colors

