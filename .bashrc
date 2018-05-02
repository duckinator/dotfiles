if [ -f "$HOME/.bash_aliases" ]; then
  . $HOME/.bash_aliases
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if which nvim &>/dev/null; then
  alias vim=nvim
fi
