if [ -f "/usr/local/share/chruby/chruby.sh" ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
elif [ -f "/usr/share/chruby/chruby.sh" ]; then
  source /usr/share/chruby/chruby.sh
  source /usr/share/chruby/auto.sh
fi
