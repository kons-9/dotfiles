#!/bin/zsh
# zsh setting
# you should install zsh before run this script
echo `cd $ZDOTDIR && git pull` > /dev/null 

function __execute () {
  source $ZDOTDIR/$1
}

# whether initialized or not
# if .initialized does not exist, initialize
if [[ ! -f $ZDOTDIR/.initialized ]]; then
  touch $ZDOTDIR/.initialized
  read "yn?want to initialize automatically? [y/N]"
  case "$yn" in
    [yY]*) 
        __execute ../start.zsh
        # restart zsh
        exec zsh -l
    ;;
    *) 
        echo "you should initialize manually."
        ;;
  esac
fi

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

# depends on os
__execute os/os.zsh

# common
__execute plugin.zsh
__execute prompt.zsh
__execute external_command.zsh
__execute misc.zsh

