# Creates a directory and then cd's to it.
mkcd() {
  if [ -z "$1" ]; then
    echo "Usage:  $0 [-p] dir"
  else
    mkdir $@
    [ "$1" = "-p" ] && shift
    cd $1
  fi
}
