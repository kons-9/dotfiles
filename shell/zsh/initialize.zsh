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
nvim_source="${dirpath}/editor/nvim"
nvim_target=$XDG_CONFIG_HOME/nvim
__makeSymLink $nvim_source $nvim_target

zsh_source="${dirpath}/shell/zsh/"
zsh_target=$XDG_CONFIG_HOME/zsh
__makeSymLink $zsh_source $zsh_target

clang_source="${dirpath}/lang/clang/.clang-format"
clang_target=$XDG_CONFIG_HOME/.clang-format
__makeSymLink $clang_source $clang_target

wezterm_source="${dirpath}/terminal/wezterm/"
wezterm_target=$XDG_CONFIG_HOME/wezterm
__makeSymLink $wezterm_source $wezterm_target

alacritty_source="${dirpath}/terminal/alacritty/"
alacritty_target=$XDG_CONFIG_HOME/alacritty
__makeSymLink $alacritty_source $alacritty_target

tmux_source="${dirpath}/tmux/"
tmux_target=$XDG_CONFIG_HOME/tmux
__makeSymLink $tmux_source $tmux_target

git_config_source="${dirpath}/git/"
git_config_target=$XDG_CONFIG_HOME/git
__makeSymLink $git_config_source $git_config_target

python_source="${dirpath}/lang/python/"
python_target="$XDG_CONFIG_HOME/python"
__makeSymLink $python_source $python_target

vscode_keybindings_source="${dirpath}/editor/vscode/keybindings.json"

zshrc_source="${dirpath}/shell/zsh/.zshenv"
zshrc_target=~/.zshenv
__makeSymLink $zshrc_source $zshrc_target

zshlocal_source="${dirpath}/shell/zsh/generated/zshrc.local"
zshlocal_target=~/.zshrc
if [ ! -e $zshlocal_source ]; then
    echo "${zshlocal_source} is not exist."
    touch $zshlocal_source
    nvim $zshlocal_source
fi
__makeSymLink $zshlocal_source $zshlocal_target

#install binaries
if [[ ! -f ${dirpath}/zsh/generated/initialized ]]; then
    source "${dirpath}/shell/zsh/initialize/linux/linux.sh"
    source "${dirpath}/shell/zsh/initialize/rust.sh"
    source "${dirpath}/shell/zsh/initialize/nvm.sh"
fi

