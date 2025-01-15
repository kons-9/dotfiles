#!/bin/env zsh
function __execute () {
  source $ZDOTDIR/$1
}
cd `dirname $0`
dirpath=`pwd`
# if XDG_CONFIG_HOME is not set, set it to ~/.xdg/config
if [ -z $XDG_CONFIG_HOME ]; then
  export XDG_CONFIG_HOME=~/.xdg/config
fi

if [[ ! -f $ZDOTDIR/.initialized ]]; then
    bash $dirpath/initialize/initialize.sh
fi

# if check is not needed and you want to replace all, please cmd `sh start.sh -y`
# if check is not needed and you don't want to replace any, please cmd `sh start.sh -n`
flag=$1 || ""

#####################
# use XDG_CONFIG_HOME
#####################
nvim_source="${dirpath}/nvim"
nvim_target=$XDG_CONFIG_HOME/nvim

zsh_source="${dirpath}/zsh/"
zsh_target=$XDG_CONFIG_HOME/zsh

clang_source="${dirpath}/clang/.clang-format"
clang_target=$XDG_CONFIG_HOME/.clang-format

wezterm_source="${dirpath}/wezterm/"
wezterm_target=$XDG_CONFIG_HOME/wezterm

alacritty_source="${dirpath}/alacritty/"
alacritty_target=$XDG_CONFIG_HOME/alacritty

tmux_source="${dirpath}/tmux/"
tmux_target=$XDG_CONFIG_HOME/tmux

git_config_source="${dirpath}/git/"
git_config_target=$XDG_CONFIG_HOME/git

python_source="${dirpath}/python/"
python_target="$XDG_CONFIG_HOME/python"

vscode_keybindings_source="${dirpath}/vscode/keybindings.json"

zshrc_source="${dirpath}/zsh/.zshenv"
zshrc_target=~/.zshenv

zshlocal_source="${dirpath}/zsh/.zshrc.local"
zshlocal_target=~/.zshrc
if [ ! -e $zshlocal_source ]; then
    echo "${zshlocal_source} is not exist, but make .zshrc.local"
    echo "because zsh require .zshrc and .zshrc is just symlink to .zshrc.local"
    touch $zshlocal_source
    nvim $zshlocal_source
fi

hammerspoon_source="${dirpath}/hotkey/hammerspoon"
hammerspoon_target=~/.hammerspoon

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

makeSymLink $nvim_source $nvim_target
makeSymLink $zsh_source $zsh_target
makeSymLink $zshrc_source $zshrc_target
makeSymLink $zshlocal_source $zshlocal_target
makeSymLink $clang_source $clang_target
makeSymLink $git_config_source $git_config_target
makeSymLink $wezterm_source $wezterm_target
makeSymLink $hammerspoon_source $hammerspoon_target
makeSymLink $python_source $python_target
