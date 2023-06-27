#!/bin/env zsh
cd `dirname $0`
path=`pwd`

# if check is not needed, please cmd `sh start.sh -y`
flag=$1 || ""

nvim_source="${path}/nvim"
nvim_target=~/.config/nvim

zsh_source="${path}/zsh/"
zsh_target=~/.config/zsh

zshrc_source="${path}/zsh/.zshenv"
zshrc_target=~/.zshenv

zshlocal_source="${path}/zsh/.zshrc.local"
zshlocal_target=~/.zshrc

clang_source="${path}/clang/.clang-format"
clang_target=~/.clang-format

git_config_source="${path}/git/.gitconfig"
git_config_target=~/.gitconfig

vscode_keybindings_source="${path}/vscode/keybindings.json"


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
    if [ -e /usr/bin/rm ]; then
	    /usr/bin/rm -rf $target
    else
	    /bin/rm -rf $target
    fi
    if [ -e /usr/bin/ln ]; then
	    /usr/bin/ln -s $source $target
    else
	    /bin/ln -s $source $target
    fi
    echo ""
  fi
}

makeSymLink $nvim_source $nvim_target
makeSymLink $zsh_source $zsh_target
makeSymLink $zshrc_source $zshrc_target
makeSymLink $zshlocal_source $zshlocal_target
makeSymLink $clang_source $clang_target
makeSymLink $git_config_source $git_config_target
