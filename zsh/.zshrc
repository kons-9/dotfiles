# zsh setting
# you should install zsh before run this script
echo `cd $ZDOTDIR && git pull` > /dev/null 

function __execute () {
  source $ZDOTDIR/$1
}

__execute util.zsh

# local setting
if [[ -f $ZDOTDIR/.zshrc.local ]]; then
  __execute .zshrc.local
else
  read "yn?create ~/.zshrc.local? [y/N]"
  case "$yn" in
    [yY]*) 
      touch $ZDOTDIR/.zshrc.local
      vim $ZDOTDIR/.zshrc.local
      __execute .zshrc.local
    ;;
    *) ;;
  esac
fi

# depends on OS
# 
## mac
if [[ `uname` == 'Darwin' ]]; then
  __execute mac.zsh
fi

## windows
if [[ "$(uname)" == 'MINGW64_NT-10.0' ]]; then
  __execute windows.zsh
fi

## linux
if [[ $OSTYPE =~ linux.* ]]; then
  ## wsl
  if [[ -e /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
    __execute linux/wsl.zsh
  fi

  ## ubuntu
  if [[ -e /etc/lsb-release ]]; then
    # install apt
    if ! type apt > /dev/null 2>&1; then
      __eecho "you need to install apt"
    fi
  fi

  ## centos
  if [[ -e /etc/centos-release ]]; then
    # install yum
    if ! type yum > /dev/null 2>&1; then
      __eecho "you need to install yum"
    fi
  fi
fi

# you need cargo for command, so you should setup rustup in each enviroment.
if ! type cargo > /dev/null 2>&1; then
  __eecho "cargo not found"
  __eecho "you need to write a config for cargo in each environment"
fi

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
      [Nn]* ) __eecho "you need $1"; return ;;
      * ) __eecho "Please answer y or n."; return;;
    esac
    echo "installing $1..."
    cargo install $1
  fi
}


# common
__execute plugin.zsh
__execute prompt.zsh
__execute external_command.zsh
__execute misc.zsh

