# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f "$HOME/.bash_aliases" ]; then
  . $HOME/.bash_aliases
fi

if [ -f "$HOME/.bash_env" ]; then
  . $HOME/.bash_env
fi
