# Functions that require internet connectivity

# Creates a directory and then cd's to it.
mkcd() {
  if [ -z "$1" ]; then
    echo "Usage:  $0 [options] dir"
    echo
    echo "Options:"
    echo "  -p    No error if existing, make parent directories as needed."
  else
    mkdir $@
    if [ "$1" = "-p" ]; then
      cd $2
    else
      cd $1
    fi
  fi
}
