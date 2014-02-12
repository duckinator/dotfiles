CLYDE=$(which clyde 2>/dev/null)
PACMAN=$(which pacman 2>/dev/null)
YAOURT=$(which yaourt 2>/dev/null)

zshload aur

if [ -f "$PACMAN" ]; then

  # Most (all?) binaries related to a package
  pacbins() {
    if [ -z "$1" ]; then
      echo "Usage:  $0 package-name"
    else
      pacman -Ql $1 | awk '{print $2}' | grep 'bin/.\{1\}'
    fi
  }

  # Smart alias for pacman. Automatically uses sudo when needed.
  if [ -f "$PACMAN" ]; then
    p(){
      case $1 in
        -Si|-Ss|-Q*|-T|-*h|'')
          pacman "$@"
          ;;
        -S*|-R*|-U)
          sudo pacman "$@" || return $?
          ;;
        *)
          pacman "$@"
          ;;
      esac
    }
  fi

  # Smart alias for clyde. Automatically uses sudo when needed.
  if [ -f "$CLYDE" ]; then
    c(){
      case $1 in
        -Si|-Ss|-Q*|-T|-*h|'')
          clyde "$@"
          ;;
        -S*|-R*|-U)
          sudo clyde "$@" || return $?
          ;;
        *)
          clyde "$@"
          ;;
      esac
    }
  fi

  # Smart alias for yaourt. Automatically uses sudo when needed.
  if [ -f "$YAOURT" ]; then
    y(){
      case $1 in
        -Si|-Ss|-Q*|-T|-*h|'')
          yaourt "$@"
          ;;
        -S*|-R*|-U)
          sudo yaourt "$@" || return $?
          ;;
        *)
          yaourt "$@"
          ;;
      esac
    }
  fi

  # 32-bit chroot
  if [ "$(uname -m)" = "x86_64" ]; then
    # clyde alias for 32-bit chroot
    if [ -f "$CLYDE" ]; then
      c32(){
        sudo clyde --root /opt/arch32 --cachedir /opt/arch32/var/cache/pacman/pkg --config /opt/arch32/etc/pacman.conf "$@" || return $?
      }
    fi

    # pacman for 32-bit chroot
    p32(){
      sudo pacman --root /opt/arch32 --cachedir /opt/arch32/var/cache/pacman/pkg --config /opt/arch32/etc/pacman.conf "$@" || return $?
    }
  fi

fi
