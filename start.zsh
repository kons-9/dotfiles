#!/bin/env zsh
cd `dirname $0`
dirpath=`pwd`

# if check is not needed, please cmd `sh start.sh -y`
flag=$1 || ""

nvim_source="${dirpath}/nvim"
nvim_target=~/.config/nvim

zsh_source="${dirpath}/zsh/"
zsh_target=~/.config/zsh

zshrc_source="${dirpath}/zsh/.zshenv"
zshrc_target=~/.zshenv

zshlocal_source="${dirpath}/zsh/.zshrc.local"
zshlocal_target=~/.zshrc

clang_source="${dirpath}/clang/.clang-format"
clang_target=~/.clang-format

wezterm_source="${dirpath}/wezterm/"
wezterm_target=~/.config/wezterm

git_config_source="${dirpath}/git/.gitconfig"
git_config_target=~/.gitconfig

vscode_keybindings_source="${dirpath}/vscode/keybindings.json"


function makeSymLink() {
  source=$1
  target=$2
  if [ ! -e $source ]; then
    echo "${source} is not exist."
    return
  fi

  if [ ! -e $target ] && [ ! -L $target ]; then
    mkdir -p `dirname $target`
    ln -s $source $target
  else
    echo "${target} is exist."
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
