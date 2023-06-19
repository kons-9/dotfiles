#!/bin/zsh

function __eecho() {
  echo $1 1>&2
}

function __check_and_install_with_cargo () {
  # if it exists, command = $2
  local command=$1
  if [ $# -eq 2 ]; then
    command=$2
  fi

  if ! type $command > /dev/null 2>&1; then
    echo "$command not found"
    read "yn?Install $1? [y/n]"
    case $yn in
      [Yy]* ) ;;
      [Nn]* ) eecho "you need $1"; exit 1;;
      * ) eecho "Please answer y or n."; exit 1;;
    esac
    echo "installing $1..."
    cargo install $1
  fi
}

function __noremap() {
  alias $1=$2
}

function __map() {
  # $1: alias name
  # external command form is _$1
  local command=(${(s: :)2})
  if alias ${command[1]} > /dev/null 2>&1; then
    # alias exists
    # replace target in $2
    local target=$(alias ${command[1]} | sed -e "s/^${command[1]}=\(.*\)/\1/")
    if [ ${#command[@]} -lt 2 ]; then
      alias $1=$target
    else
      alias $1="$target ${command[2,-1]}"
    fi
  else
    alias $1=$2
  fi
}

