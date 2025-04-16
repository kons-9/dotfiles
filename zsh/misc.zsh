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
