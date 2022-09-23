cd `dirname $0`
path=`pwd`

nvim_source="${path}/nvim"
nvim_target=~/.config/nvim

zsh_source="${path}/zsh-setting/zsh"
zsh_target=~/.zsh

zshrc_source="${path}/zsh-setting/zshrc"
zshrc_target=~/.zshrc

clang_source="${path}/clang-format"
clang_target=~/.clang-format

git_config_source="${path}/gitconfig"
git_config_target=~/.gitconfig

function symlink() {
  source=$1
  target=$2

  if [ ! -e $target ] && [ ! -L $target ]; then
    ln -s $source $target
  else
    echo "${target} is exist."
    read -p "replace it? (y/n) :" YN
    if [ $YN = "y" ];then
      rm -rf $target
      ln -s $source $target
    fi
  fi
}

symlink $nvim_source $nvim_target
symlink $zsh_source $zsh_target
symlink $zshrc_source $zshrc_target
symlink $clang_source $clang_target
