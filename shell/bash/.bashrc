# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

VIM_EXEC=vim

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# set status bar
# {user}@{host} {path} {git_branch} {git_status} {time}
function set_prompt() {
    local GREEN="\[\033[0;32m\]"
    local BLUE="\[\033[0;34m\]"
    local YELLOW="\[\033[0;33m\]"
    local RED="\[\033[0;31m\]"
    local CYAN="\[\033[0;36m\]"
    local MAGENTA="\[\033[0;35m\]"
    local WHITE="\[\033[0;37m\]"
    local RESET="\[\033[0m\]"
    
    # if ssh, add (ssh) to the prompt
    local ssh_info=""
    if [[ $SSH_CLIENT || $SSH_TTY ]]; then
        ssh_info="(ssh) "
    fi

    local user=$(whoami)
    local host=$(hostname)
    local current_shell=$(basename `ps -p $$ -o args= | cut -d' ' -f1`)
    local path=$(pwd)
    if [[ $path == *"$HOME"* ]]; then
        path=${path//$HOME/\~}
    fi
    local git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    local git_status=""
    local staged_git_status=$(git status --porcelain 2>/dev/null | grep -E '^M ' | wc -l)
    if [ $staged_git_status -gt 0 ]; then
        git_status+="+$staged_git_status "
    fi
    local modified_git_status=$(git status --porcelain 2>/dev/null | grep -E '^ M' | wc -l)
    if [ $modified_git_status -gt 0 ]; then
        git_status+="!$modified_git_status "
    fi
    local untracked_git_status=$(git status --porcelain 2>/dev/null | grep -E '^\?\?' | wc -l)
    if [ $untracked_git_status -gt 0 ]; then
        git_status+="?$untracked_git_status "
    fi
    # local unmerged_git_status=$(git status --porcelain 2>/dev/null | grep -E '^U' | wc -l)
    # local conflicted_git_status=$(git status --porcelain 2>/dev/null | grep -E '^UU' | wc -l)
    # Remove trailing space
    git_status=$(echo "$git_status" | sed 's/[[:space:]]*$//')

    local time=$(date +"%Y-%m-%d %H:%M:%S")
    
    PS1="$GREEN$user@$host[$current_shell]$RESET: $YELLOW$path$RESET [$CYAN$git_branch$RESET $RED$git_status$RESET] [$WHITE$time$RESET]\n$ssh_info\$ "
}
# set_prompt
PROMPT_COMMAND=set_prompt

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

