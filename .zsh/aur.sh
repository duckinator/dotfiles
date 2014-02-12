# Built-in AUR helper

if $(exists pacman); then
  function aur_fetch() {
    cd $AUR_DIR

    # TODO: Possibly make this more intelligent.
    # Such as suggesting alternatives if it could not be found.
    url="http://aur.archlinux.org/packages/$pkg/$pkg.tar.gz"
    wget $url -O $tar || return $?
  }

  function aur_extract() {
    cd $AUR_DIR
    tar -xvf $tar || return $?

    mv $pkg $dir
    cd $dir
  }

  function aur_build() {
    makepkg -s || return $?
    $SUDO pacman -U ./$pkg-*.pkg.tar.xz
  }

  function aur_setup() {
    __AUR_SETUP_DONE=false
    date="$(date +'%Y-%m-%d-%H:%M')"
    dir="$pkg-$date"
    tar="./$dir.tar.gz"

    mkdir -p $AUR_DIR || return $?
    cd $AUR_DIR || return $?
    __AUR_SETUP_DONE=true
  }

  aur() {
    cd - &>/dev/null
    _PREV_DIR="$PWD"
    cd - &>/dev/null
    _CUR_DIR="$PWD"

    _USE_SUDO=false
    _COMMAND=""

    [ -z "$AUR_DIR" ] && AUR_DIR="/tmp/aur-$USER/"

    # ???
    SUDO="sudo"

    pkg="$1"
    
    case $1 in
      -S*|-R*|-U*|--install|install)
        _USE_SUDO=true
    esac

    if ! $_USE_SUDO; then
      SUDO=
    fi
      
    case $1 in
      -S|--install|install)
        pkg="$2"
        aur_setup
        if ! $__AUR_SETUP_DONE; then
          echo
          echo "Could not setup $AUR_DIR properly, exiting."
          return 1
        fi
        #echo "NOT IMPLEMENTED"
        aur_fetch
        aur_extract
        aur_build
        ;;
      -Ss|--search)
        echo "NOT IMPLEMENTED"
        ;;
      --help|-h|help)
        echo "Usage: $0 <operation> PACKAGE"
        echo "operations:"
        echo "    $0 {-S install} PACKAGE   install PACKAGE"
        echo "    $0 {-Ss search} PACKAGE   search AUR for PACKAGE"
        echo
        echo "For all other operations, use \`pacman'"
        ;;
      *)
        $0 --install $@
        ;;
    esac

    unset _USE_SUDO _COMMAND AUR_DIR SUDO pkg date dir tar __AUR_SETUP_DONE

    # Leave no traces, even with `cd -` and the like.
    cd $_PREV_DIR
    cd $_CUR_DIR
  }
fi
