set SHELL fish
set UID (id -u)

if test -d "/var/run/user/$UID"
  export XDG_RUNTIME_DIR="/var/run/user/$UID"
end

# Re: .npm-global: https://docs.npmjs.com/getting-started/fixing-npm-permissions
set -gx PATH "$HOME/bin" "$HOME/.local/bin" "$HOME/.gem/ruby/bin" "$HOME/.npm-global/bin" "/bin" "/usr/bin" "/sbin" "/usr/sbin"

if test -f ~/.cargo/env
  source ~/.cargo/env
end

if which nvim >/dev/null ^/dev/null
  export EDITOR=nvim
else if which vim >/dev/null ^/dev/null
  export EDITOR=vim
else
  export EDITOR=nano
end

source ~/.bash_env

if test -f "$HOME/.env.fish.user"
  source "$HOME/.env.fish.user"
end
