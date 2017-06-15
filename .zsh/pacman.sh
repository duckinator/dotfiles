if $(exists pacman); then
  # Most (all?) binaries related to a package
  pacbins() {
    if [ -z "$1" ]; then
      echo "Usage:  $0 package-name"
    else
      # \ in \grep means don't use the alias, just all it directly.
      pacman -Ql $1 | awk '{print $2}' | \grep /bin/
    fi
  }
fi
