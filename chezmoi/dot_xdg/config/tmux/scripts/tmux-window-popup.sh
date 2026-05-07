#!/bin/bash

# 現在のセッション名を取得
current_session=$(tmux display-message -p '#S')

while true; do
    clear
    echo "== TMUX WINDOWS (in session: $current_session) =="
    echo "[n] New window"
    echo "[a] Switch to window"
    echo "[r] Rename window"
    echo "[d] Delete window"
    echo "[q] Quit"
    echo

    read -p "Select action: " action

    case "$action" in
        n)
            read -p "New window name: " newname
            if [ -z "$newname" ]; then
                tmux new-window
            else
                tmux new-window -n "$newname"
            fi
            ;;
        a)
            target=$(tmux list-windows -t "$current_session" -F "#{window_index}: #{window_name}" | fzf --prompt="Switch to window: ")
            if [ -n "$target" ]; then
                index=$(echo "$target" | cut -d: -f1)
                tmux select-window -t "$current_session:$index"
                exit 0
            fi
            ;;
        r)
            target=$(tmux list-windows -t "$current_session" -F "#{window_index}: #{window_name}" | fzf --prompt="Rename window: ")
            if [ -n "$target" ]; then
                index=$(echo "$target" | cut -d: -f1)
                read -p "New name for window $target: " newname
                [ -n "$newname" ] && tmux rename-window -t "$current_session:$index" "$newname"
            fi
            ;;
        d)
            target=$(tmux list-windows -t "$current_session" -F "#{window_index}: #{window_name}" | fzf --prompt="Delete window: ")
            if [ -n "$target" ]; then
                index=$(echo "$target" | cut -d: -f1)
                read -p "Are you sure you want to delete window $target? [y/N] " confirm
                [[ "$confirm" =~ ^[Yy]$ ]] && tmux kill-window -t "$current_session:$index"
            fi
            ;;
        q)
            exit 0
            ;;
        *)
            exit 0
            ;;
    esac
done

