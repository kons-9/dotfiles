#!/bin/zsh

function __eecho() {
  echo $1 1>&2
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
    local target=$(alias ${command[1]} | sed -e "s/^${command[1]}=\(.*\)/\1/" | sed -e "s/'//g")
    target=`echo target` | sed -e ""
    if [ ${#command[@]} -lt 2 ]; then
      alias $1=$target
    else
      alias $1="$target ${command[2,-1]}"
    fi
  else
    alias $1=$2
  fi
}

