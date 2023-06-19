# zsh setting
# you should install zsh before run this script

function __execute () {
  source $ZDOTDIR/$1
}

__execute util.zsh

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
if [[ $OSTYPE == 'linux*' ]]; then
  ## wsl
  if [[ -e /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
    __execute linux/wsl.zsh
  fi

  ## ubuntu
  if [[ -e /etc/lsb-release ]]; then
    # install apt
    if ! type apt > /dev/null 2>&1; then
      __eecho "you need to install apt"
      exit 1
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
  exit 1
fi

# common
__execute plugin.zsh
__execute prompt.zsh
__execute external_command.zsh
__execute misc.zsh

# local setting
if [[ -f $ZDOTDIR/.zshrc.local ]]; then
else
  read -p "create ~/.zshrc.local? [y/N]" yn
  case "$yn" in
    [yY]*) ;;
    *) exit 0;;
  esac
  touch $ZDOTDIR/.zshrc.local
  vim $ZDOTDIR/.zshrc.local
  execute .zshrc.local
fi

