if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias vi=$VIM_EXEC
alias vim=$VIM_EXEC
alias nvim=$VIM_EXEC
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'

alias ls='ls -h --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
function git_sync(){
    git fetch --prune && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -d
}

alias mcd='_mkdir_and_cd'
alias mnvim='_measure_nvim_startup_time'
alias c='_cd_and_ls'
alias gsync='git_sync'