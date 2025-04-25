VIM_EXEC=vim

alias vi=$VIM_EXEC
alias vim=$VIM_EXEC
alias nvim=$VIM_EXEC
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ls='ls -h'
alias ll='ls -l'
alias la='ls -a'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'

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

# set status bar
# {user}@{host} {path} {git_branch} {git_status} {time}
function set_prompt() {
    local user=$(whoami)
    local host=$(hostname)
    local path=$(pwd)
    local git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    local git_status=$(git status --porcelain 2>/dev/null | wc -l)
    local time=$(date +"%Y-%m-%d %H:%M:%S")
    
    PS1="[$user@$host $path] [$git_branch] [$git_status] [$time]\n$ "
}
# set_prompt
PROMPT_COMMAND=set_prompt


