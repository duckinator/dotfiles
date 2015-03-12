if ! which ripl &>/dev/null; then
  alias ripl="echo 'Installing ripl...' && sed 's/%w\[\(.*\)\].*/\1/' ~/.riplrc | sed 's/^\| / ripl-/g' | xargs gem install && unalias ripl && echo 'Done! Executing ripl as normal.' && ripl"
fi
