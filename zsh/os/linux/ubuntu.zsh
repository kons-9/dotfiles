#!/bin/zsh
#
function __apt_update() {
    echo "updating apt setting"
    nohup sudo apt update && sudo apt upgrade -y
    echo `date +%Y%m%d` > $ZDOTDIR/.apt_update
}
#update apt
if [[ ! -f $ZDOTDIR/.apt_update ]]; then
    touch $ZDOTDIR/.apt_update
    __apt_update
else
    last_update=`cat $ZDOTDIR/.apt_update`
    now=`date +%Y%m%d`
    # compare date and if today >= last_update + 1day, update
    if [[ $now -ge $((last_update + 1)) ]]; then
        __apt_update
    fi
fi
