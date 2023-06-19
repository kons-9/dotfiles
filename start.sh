cd `dirname $0`
path=`pwd`

# if check is not needed, please cmd `sh start.sh -y`
flag=$1

nvim_source="${path}/nvim"
nvim_target=~/.config/nvim

zsh_source="${path}/zsh/"
zsh_target=~/.config/zsh

zshrc_source="${path}/zsh/.zshenv"
zshrc_target=~/.zshenv

clang_source="${path}/clang/.clang-format"
clang_target=~/.clang-format

git_config_source="${path}/git/.gitconfig"
git_config_target=~/.gitconfig

vscode_keybindings_source="${path}/vscode/keybindings.json"

function symlink() {
  source=$1
  target=$2

  if [ ! -e $target ] && [ ! -L $target ]; then
    mkdir -p `dirname $target`
    ln -s $source $target
  else
    echo "${target} is exist."
    if [ ! "$flag" = "-y" ]; then
      read -p "replace it? (y/n) :" YN
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

symlink $nvim_source $nvim_target
symlink $zsh_source $zsh_target
symlink $zshrc_source $zshrc_target
symlink $clang_source $clang_target
symlink $git_config_source $git_config_target
