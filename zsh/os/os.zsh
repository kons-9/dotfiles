#!/bin/zsh
# depends on OS
## mac
if [[ `uname` == 'Darwin' ]]; then
  __execute os/mac.zsh
fi

## windows
if [[ "$(uname)" == 'MINGW64_NT-10.0' ]]; then
  __execute os/windows.zsh
fi

## linux
if [[ $OSTYPE =~ linux.* ]]; then
  __execute os/linux.zsh

  ## wsl
  if [[ -e /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
    __execute os/linux/wsl.zsh
  fi

  ## depends on distro

  ## ubuntu
  if [[ -e /etc/lsb-release ]]; then
    __execute os/linux/ubuntu.zsh
  fi

  ## centos
  if [[ -e /etc/centos-release ]]; then
    __execute os/linux/centos.zsh
  fi
fi
