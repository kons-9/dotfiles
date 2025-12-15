#!/bin/zsh

function __is_command_available() {
    command -v "$1" &>/dev/null
}

function __eecho() {
    echo "$1" >&2
}

function __noremap() {
    local name=$1
    local cmd=$2
    local cmd_name=${cmd%% *}

    if ! __is_command_available "$cmd_name"; then
        __eecho "$cmd_name is not found"
        return
    fi

    # alias 作成（安全）
    eval "alias $name='${cmd//\'/\'\\\'\'}'"
}

function __map() {
    local name=$1
    local cmd="$2"

    local cmd_name=${cmd%% *}
    local rest=${cmd#"$cmd_name"}
    local count=0
    local max_expansions=10

    # alias 展開ループ
    while alias "$cmd_name" &>/dev/null; do
        ((count++))
        if (( count > max_expansions )); then
            __eecho "alias expansion exceeded $max_expansions times for $cmd_name"
            break
        fi
        local expanded
        expanded=$(alias "$cmd_name")
        # alias 出力: alias cd='z'
        cmd_name=${expanded#*=}      # =以降
        cmd_name=${cmd_name#\'}       # 前後のシングルクォート削除
        cmd_name=${cmd_name%\'} 
        cmd="$cmd_name$rest"
        rest=${cmd#"$cmd_name"}
    done

    __noremap "$name" "$cmd"
}

