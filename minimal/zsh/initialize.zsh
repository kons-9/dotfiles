#!/bin/env zsh
cd `dirname $0`
dirpath=`pwd`/../..

source "${dirpath}/shell/zsh/.zshenv"

function __makeSymLink() {
    source=$1
    target=$2
    if [ ! -e $source ]; then
        echo "${source} is not exist."
        return
    fi
    rm -rf $target
    mkdir -p `dirname $target`
    ln -s $source $target
    echo "make symlink ${target}!"
}

#####################
# use XDG_CONFIG_HOME
#####################
zsh_source="${dirpath}/shell/zsh/"
zsh_target=$XDG_CONFIG_HOME/zsh
__makeSymLink $zsh_source $zsh_target

wezterm_source="${dirpath}/terminal/wezterm/"
wezterm_target=$XDG_CONFIG_HOME/wezterm
__makeSymLink $wezterm_source $wezterm_target

zshlocal_source="${dirpath}/shell/zsh/generated/zshrc.local"
zshlocal_target=~/.zshrc
if [ ! -e $zshlocal_source ]; then
    echo "${zshlocal_source} is not exist."
    touch $zshlocal_source
    nvim $zshlocal_source
fi
__makeSymLink $zshlocal_source $zshlocal_target

#install binaries
if [[ ! -f ${dirpath}/shell/zsh/generated/initialized ]]; then
    source "${dirpath}/shell/zsh/initialize/linux/linux.sh"
    source "${dirpath}/shell/zsh/initialize/rust.sh"
    source "${dirpath}/shell/zsh/initialize/nvm.sh"
    touch ${dirpath}/shell/zsh/generated/initialized
fi
