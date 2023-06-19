# if you have installed windows version of nvim, cargo, git, python, node, you can use this file to make them work in wsl

function __check_and_install() {
  if ! type $1.exe > /dev/null 2>&1; then
    echo "$1.exe not found"
    read "yn?Install $1 in wsl? [y/n]"
    case $yn in
      [Yy]* ) ;;
      [Nn]* ) eecho "you need $1"; exit 1;;
      * ) eecho "Please answer y or n."; exit 1;;
    esac
    sudo apt install $1
  else
    alias $1="$1.exe"
  fi
}

__check_and_install nvim
__check_and_install rustup
__check_and_install cargo
__check_and_install git
__check_and_install python3
__check_and_install node
