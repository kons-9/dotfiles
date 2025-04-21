#!/bin/bash

while true; do
    clear
    echo "== TMUX SESSIONS =="
    echo "[n] New session"
    echo "[a] Attach session"
    echo "[r] Rename session"
    echo "[d] Delete session"
    echo "[q] Quit"
    echo

    read -p "Select action: " action

    case "$action" in
        n)
            read -p "New session name: " new
            if [ -n "$new" ]; then
                tmux new-session -d -s "$new"
                tmux switch-client -t "$new"
                exit 0
            fi
            ;;
        a)
            session=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Attach to: ")
            if [ -n "$session" ]; then
                # 動作：ポップアップでアタッチ
                tmux display-popup -E "tmux attach-session -t '$session'"
                exit 0
            fi
            ;;
        r)
            session=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Rename which session: ")
            if [ -n "$session" ]; then
                read -p "New name for session '$session': " newname
                if [ -n "$newname" ]; then
                    tmux rename-session -t "$session" "$newname"
                fi
            fi
            ;;
        d)
            session=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Delete which session: ")
            if [ -n "$session" ]; then
                read -p "Are you sure you want to delete session '$session'? [y/N] " confirm
                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    tmux kill-session -t "$session"
                fi
            fi
            ;;
        q)
            exit 0
            ;;
        *)
            echo "Invalid action."
            sleep 1
            ;;
    esac
done

