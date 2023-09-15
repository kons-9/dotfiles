# if you have installed windows version of nvim, cargo, git, python, node, you can use this file to make them work in wsl
local flag=true

function __apt_update() {
  sudo apt update
  sudo apt upgrade
}

function __check_and_install_in_wsl() {
  if type $1 > /dev/null 2>&1; then
    return 
  fi
  if ! type $1.exe > /dev/null 2>&1; then
    echo "$1.exe not found"
    read "yn?Install $1 by winget? [y/n]"
    case $yn in
      [Yy]* ) winget.exe install $1;alias $1="$1.exe";return;;
      [Nn]* ) ;;
      * ) __eecho "Please answer y or n."; return;;
    esac

    read "yn?Install $1 in wsl? [y/n]"
    case $yn in
      [Yy]* ) ;;
      [Nn]* ) __eecho "you need $1"; return;;
      * ) __eecho "Please answer y or n."; return;;
    esac
    if [[ flag == true ]]; then
      flag=false
      __apt_update
    fi
    sudo apt install $1
  else
    alias $1="$1.exe"
  fi
}

# __check_and_install_in_wsl nvim
__check_and_install_in_wsl git
__check_and_install_in_wsl python3
__check_and_install_in_wsl node

source $CARGO_HOME/env
# cargo(rustup) install
if ! type rustup > /dev/null 2>&1; then
  read "yn?Install rustup? [y/n]"
  case $yn in
    [Yy]* ) ;;
    [Nn]* ) break;;
    * ) __eecho "Please answer y or n."; break;;
  esac
  curl https://sh.rustup.rs -sSf | sh
  echo ""
  echo "You may need other essential tools when you build rust tools."
  read "yn?Install build-essential, pkg-config, libssl-dev? [y/n]"
  case $yn in
    [Yy]* ) ;;
    [Nn]* ) break;;
    * ) __eecho "Please answer y or n."; break;;
  esac
  if [[ flag == true ]]; then
    __apt_update
  fi
  sudo apt install build-essential pkg-config libssl-dev;
  source "/home/wslmtl/.xdg/data/rust/cargo/env"
  cargo install cargo-binstall
fi

# nvim install
if ! type nvim > /dev/null 2>&1; then
  read "yn?Install nvim? [y/n]"
  case $yn in
    [Yy]* ) ;;
    [Nn]* ) break;;
    * ) __eecho "Please answer y or n."; break;;
  esac
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  sudo mv nvim.appimage /usr/local/bin/nvim

  echo "You may need other essential tools when you build rust tools."
  read "yn?Install libfuse2? [y/n]"
  case $yn in
  [Yy]* ) ;;
  [Nn]* ) break;;
  * ) __eecho "Please answer y or n."; break;;
  esac
  if [[ flag == true ]]; then
    __apt_update
  fi
  sudo apt install libfuse2
fi

# deno install
if ! type deno > /dev/null 2>&1; then
  read "yn?Install deno? [y/n]"
  case $yn in
    [Yy]* ) ;;
    [Nn]* ) return;;
    * ) __eecho "Please answer y or n."; return;;
  esac
  if ! type unzip > /dev/null 2>&1; then
    echo "you need unzip"
    read "yn?Install unzip? [y/n]"
    case $yn in
      [Yy]* ) ;;
      [Nn]* ) return;;
      * ) __eecho "Please answer y or n."; return;;
    esac
    sudo apt install unzip
  fi
  curl -fsSL https://deno.land/x/install/install.sh | sh

  echo 'export DENO_INSTALL="$HOME/.deno"' >> $ZDOTDIR/.zshrc.local
  echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> $ZDOTDIR/.zshrc.local
fi
