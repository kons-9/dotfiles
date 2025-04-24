#!/bin/zsh
#
function __apt_update() {
    if [ "$NO_SUDO" != "1" ]; then
        echo "updating apt setting"
        sudo apt update && sudo apt upgrade -y
        echo `date +%Y%m%d` > $ZDOTDIR/generated/apt_update
    fi
}
#update apt
if [[ ! -f $ZDOTDIR/generated/apt_update ]]; then
    touch $ZDOTDIR/generated/apt_update
    __apt_update
else
    last_update=`cat $ZDOTDIR/generated/apt_update`
    now=`date +%Y%m%d`
    # compare date and if today >= last_update + 1day, update
    if [[ $now -ge $((last_update + 1)) ]]; then
        __apt_update
    fi
fi
