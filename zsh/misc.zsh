#!/bin/zsh
export EDITOR=nvim

# color
autoload -Uz colors: colors

# auto complete
autoload -U compinit; compinit

zstyle ':completion:*' list-colors "${LS_COLORS}"

# spell miss
setopt correct

# history
HISTFILE=$XDG_CACHE_HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_all_dups
setopt share_history
setopt hist_reduce_blanks

# Ctrl D 
setopt ignore_eof

# time command
TIMEFMT=$'%J\n%U user\n%S system\n%P cpu\n%*E total'

# alias
__map vi 'nvim'
__map vim 'nvim'
__map .. 'cd ..'
__map ... 'cd ../..'
__map .... 'cd ../../..'
__map ..... 'cd ../../../..'
__map ls 'ls -h'
__map ll 'ls -l'
__map cp 'cp -i'
__map mv 'mv -i'
__map rm 'rm -i'
__map la 'ls -a'
__map gs 'git status'
__map gd 'git diff'
__map sozsh 'source ~/.zshrc'

# alias for my command
function _mkdir_and_cd(){
    mkdir $1
    cd $1
}

function _measure_nvim_startup_time(){
  nvim --startuptime tmp.log +q && cat tmp.log && rm -rf tmp.log
}

function _cd_and_ls(){
  cd $1
  ls
}

__noremap mcd '_mkdir_and_cd'
__noremap mnvim '_measure_nvim_startup_time'
__noremap c '_cd_and_ls'
