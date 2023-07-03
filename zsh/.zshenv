# HOME=/mnt/c/Users/gotos
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi
ZDOTDIR=$HOME/.config/zsh
XDG_CONFIG_HOME=$HOME/.config
. "$HOME/.cargo/env"
