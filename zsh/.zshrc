#!/bin/zsh
# zsh setting
# read .zsh_update and get date of last update
if [[ ! -f $ZDOTDIR/.zsh_update ]]; then
    now=`date +%Y%m%d`
    echo `cd $ZDOTDIR && git pull --all` > /dev/null 
    echo $now > $ZDOTDIR/.zsh_update
else
    last_update=`cat $ZDOTDIR/.zsh_update`
    now=`date +%Y%m%d`
    # compare date and if today >= last_update + 1day, update
    if [[ $now -ge $((last_update + 1)) ]]; then
        echo "updating zsh setting"
        echo `cd $ZDOTDIR && git pull --all` 1> /dev/null
        echo $now > $ZDOTDIR/.zsh_update
    fi
fi

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

# you need cargo for command, so you should setup rustup in each enviroment.
source $CARGO_HOME/env

# common
__execute plugin.zsh
__execute prompt.zsh
__execute external_command.zsh
__execute misc.zsh

