# Functions that require internet connectivity

# Markdown to HTML, via documentup.com
function md2html() {
  out=$2
  if [ -z "$1" ]; then
    echo "Usage: $0 [filename]"
    return 1
  fi
  
  if [ -z "${out}" ]; then
    out=$(basename $(echo $1 | sed 's/.md$/.html/'))
  fi

  local CONTENT="${1//&/%26}"
  CONTENT="${CONTENT//\?/%3F}"
  
  curl -X POST --data-urlencode content@${CONTENT} \
    http://documentup.com/compiled > $out &>/dev/null
}

# md2html, toss it in /tmp, open, delete.
function readme() {
  _FILE="/tmp/readme-$(date +'%s').html"
  _POSSIBLE_README_MD=(readme.md readme.MD readme.markdown readme.MARKDOWN README.md README.MD README.markdown README.MARKDOWN)
  _POSSIBLE_README_TXT=(readme readme.txt readme.TXT README README.txt README.TXT)
  
  # Redundant redundancy is redundant
  for ((i=0;i<${#_POSSIBLE_README_MD};i++)); do
    if [ -f "${_POSSIBLE_README_MD[$i]}" ]; then
      echo -n "Downloading markdown version... "
      md2html "${_POSSIBLE_README_MD[$i]}" "${_FILE}"
      echo "Done."
      echo -n "Opening in browser... "
      $BROWSER "${_FILE}"
      echo "Done"
      sleep 1
      rm "${_FILE}"
      return
    fi
  done
  
  for ((i=0;i<${#_POSSIBLE_README_TXT};i++)); do
    if [ -f "${_POSSIBLE_README_TXT[$i]}" ]; then
      $BROWSER "${_POSSIBLE_README_TXT[$i]}"
      return
    fi
  done

  echo "Can't find README file."
  return 1
}

# Text editing

# `e` runs your preferred commandline text editor, as defined with $EDITOR
function e() {
  if [ -n "${EDITOR}" ]; then
    $EDITOR $@
  else
    echo 'Please define $EDITOR before using `'$0'`.'
  fi
}

# `ge` runs your preferred non-commandline text editor, as defined with $GUI_EDITOR
function ge() {
  if [ -n "${GUI_EDITOR}" ]; then
    $GUI_EDITOR $@
  else
    echo 'Please define $GUI_EDITOR before using `'$0'`.'
  fi
}

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

# Just an alias to xdg-open. Is this needed? At all?
open() {
	xdg-open $@ 2>/dev/null
}

# Disables the dynamic git/hg prompt
function static_prompt() {
	_ZSH_DYNAMIC_PROMPT=false
}

# Enables the dynamic git/hg prompt
function dynamic_prompt() {
	_ZSH_DYNAMIC_PROMPT=true
}

