#!/bin/zsh
function __eecho() {
  echo $1 1>&2
}

# aliasを作成する関数, そのままaliasを作成する
function __noremap() {
  alias $1=$2
}

# aliasを作成する関数
# $1: alias name
# $2: command
# commandが実行不可能な場合は、aliasを作成しない
# コマンドにaliasがある場合はそのaliasを展開してaliasを作成する
function __map() {
    local name=$1
    local target_command=$2
    
    # 分割してコマンドを取得
    local target_command_list=(${(z)target_command})
    # コマンドが実行可能か確認
    if ! command -v ${target_command_list[1]} &> /dev/null; then
        __eecho "${target_command_list[1]} is not found"
        return
    fi

    # target_command_listの最初の要素にaliasがある場合は、aliasを展開する
    if alias ${target_command_list[1]} &> /dev/null; then
        # 例: 
        # __map cd "z"
        # __map .. "cd .."
        # の場合、
        # % alias ..
        # ..='z ..'
        # が作成される
        target_command_list[1]=$(alias ${target_command_list[1]} | sed -e "s/${target_command_list[1]}=//" -e "s/'//g" -e 's/"//g')
    fi
    target_command=$(echo $target_command_list | sed -e 's/ /\\ /g' -e 's/\\ / /g')
    __noremap $name "$target_command"
}

