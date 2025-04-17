#!/bin/env zsh
cd `dirname $0`
dirpath=`pwd`

source "${dirpath}/zsh/.zshenv"
source "${dirpath}/zsh/.zshrc"

if [[ ! -f $ZDOTDIR/.initialized ]]; then
    bash $dirpath/initialize/initialize.sh
fi

# if check is not needed and you want to replace all, please cmd `sh start.sh -y`
# if check is not needed and you don't want to replace any, please cmd `sh start.sh -n`
flag=$1 || ""

function makeSymLink() {
    source=$1
    target=$2
    if [ ! -e $source ]; then
        echo "${source} is not exist."
        return
    fi

    if [ ! -e $target ] && [ ! -L $target ]; then
        echo "make symlink ${target}!"
        mkdir -p `dirname $target`
        ln -s $source $target
    else
        echo "${target} is exist."
        if [ "$flag" = "-n" ]; then
            echo "skip ${target}!"
            return 
        fi
        if [ ! "$flag" = "-y" ]; then
            read "YN?replace it? (y/n) :"
            if [ $YN = "n" ];then
                return
            elif [ ! $YN = "y" ];then
                echo "please input y or n"
                return
            fi
        fi
        echo "replace ${target}!"
        rm -rf $target
        ln -s $source $target
        echo ""
    fi
}

#####################
# use XDG_CONFIG_HOME
#####################
nvim_source="${dirpath}/nvim"
nvim_target=$XDG_CONFIG_HOME/nvim
makeSymLink $nvim_source $nvim_target

zsh_source="${dirpath}/zsh/"
zsh_target=$XDG_CONFIG_HOME/zsh
makeSymLink $zsh_source $zsh_target

clang_source="${dirpath}/clang/.clang-format"
clang_target=$XDG_CONFIG_HOME/.clang-format
makeSymLink $clang_source $clang_target

wezterm_source="${dirpath}/wezterm/"
wezterm_target=$XDG_CONFIG_HOME/wezterm
makeSymLink $wezterm_source $wezterm_target

alacritty_source="${dirpath}/alacritty/"
alacritty_target=$XDG_CONFIG_HOME/alacritty
makeSymLink $alacritty_source $alacritty_target

tmux_source="${dirpath}/tmux/"
tmux_target=$XDG_CONFIG_HOME/tmux
makeSymLink $tmux_source $tmux_target

git_config_source="${dirpath}/git/"
git_config_target=$XDG_CONFIG_HOME/git
makeSymLink $git_config_source $git_config_target

python_source="${dirpath}/python/"
python_target="$XDG_CONFIG_HOME/python"
makeSymLink $python_source $python_target

vscode_keybindings_source="${dirpath}/vscode/keybindings.json"

zshrc_source="${dirpath}/zsh/.zshenv"
zshrc_target=~/.zshenv
makeSymLink $zshrc_source $zshrc_target

zshlocal_source="${dirpath}/zsh/.zshrc.local"
zshlocal_target=~/.zshrc
if [ ! -e $zshlocal_source ]; then
    echo "${zshlocal_source} is not exist, but make .zshrc.local"
    echo "because zsh require .zshrc and .zshrc is just symlink to .zshrc.local"
    touch $zshlocal_source
    nvim $zshlocal_source
fi
makeSymLink $zshlocal_source $zshlocal_target

hammerspoon_source="${dirpath}/hotkey/hammerspoon"
hammerspoon_target=~/.hammerspoon
makeSymLink $hammerspoon_source $hammerspoon_target
