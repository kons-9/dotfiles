#!/usr/bin/env bash

TERMINAL_BIN="${1}"
NAME_WINDOW_SEARCH="${2}"

function toggle() {
  local WINDOW_ID=$(xdotool search --name "${NAME_WINDOW_SEARCH}")

  if [[ ${#WINDOW_ID} -gt 0 ]]; then
    xprop -id "${WINDOW_ID}" | grep _NET_WM_STATE_FOCUSED 1>/dev/null
    if [[ $? -eq 0 ]]; then
      # echo "Focused->Hidden"
      xdotool windowminimize "${WINDOW_ID}"
    else
      # echo "Hidden/Unfocused->Focused"
      xdotool windowactivate "${WINDOW_ID}"
    fi
  else
    zsh -c "${TERMINAL_BIN}" &
  fi
}

toggle
