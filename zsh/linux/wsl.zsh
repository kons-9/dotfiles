# if you have installed windows version of nvim, cargo, git, python, node, you can use this file to make them work in wsl

function __check_and_install_in_wsl() {
  if type $1 > /dev/null 2>&1; then
    return 
  fi
  if ! type $1.exe > /dev/null 2>&1; then
    echo "$1.exe not found"
    read "yn?Install $1 by winget? [y/n]"
    case $yn in
      [Yy]* ) winget.exe install $1;;
      [Nn]* ) ;;
      * ) __eecho "Please answer y or n."; return;;
    esac

    read "yn?Install $1 in wsl? [y/n]"
    case $yn in
      [Yy]* ) ;;
      [Nn]* ) __eecho "you need $1"; return;;
      * ) __eecho "Please answer y or n."; return;;
    esac
    sudo apt install $1
  else
    alias $1="$1.exe"
  fi
}

__check_and_install_in_wsl nvim
__check_and_install_in_wsl rustup
__check_and_install_in_wsl cargo
__check_and_install_in_wsl git
__check_and_install_in_wsl python3
__check_and_install_in_wsl node


