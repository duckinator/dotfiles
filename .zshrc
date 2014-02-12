# vim: set ft=sh:

source $HOME/.zsh/main.sh

if [ -n "$SSH_CONNECTION" ]; then
    remote
fi

#remote # Uncomment this for remote prompts.

zshload completion
zshload history
zshload bind
zshload colors
zshload opts

zshload custom_colors
zshload prompt

# disable flow control
stty -ixon -ixoff

zshload functions
zshload alias
zshload grepfix
zshload chruby # Prefer chruby
which chruby &>/dev/null || typeset -f chruby &>/dev/null || zshload rbenv # Fall back to rbenv if we can't find chruby.
# RVM would be next, but tries to murder my laptop. Add it to ~/.zshrc.user if you want it.
zshload shimmy
zshload dagd
zshload xautolock
zshload android_sdk

# ArchLinux-specific stuff
[ "$(cat /etc/issue | head -n1 | cut -d ' ' -f 1-2)" ] && zshload archlinux

if [ ! -f "$HOME/.zshenv" ] || [ -n "${SSH_TTY}" ] || [ -n "${VNCDESKTOP}" ]; then
    zshload path
fi
zshload env

# The dynamic prompt is buggy
static_prompt

[ -f "$HOME/.zshrc.user" ] && source $HOME/.zshrc.user

zshload todo

[ -n "${__ZSH_TODO_EXEC}" ] && which $__ZSH_TODO_EXEC &>/dev/null && todo_summary

clean
