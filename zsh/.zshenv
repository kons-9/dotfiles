
export XDG_CONFIG_HOME="$HOME/.xdg/config"
export XDG_DATA_HOME="$HOME/.xdg/data"
export XDG_STATE_HOME="$HOME/.xdg/state"
export XDG_CACHE_HOME="$HOME/.xdg/cache"

export ZDOTDIR=$XDG_CONFIG_HOME/zsh

export CARGO_HOME="$XDG_DATA_HOME/rust/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rust/rustup"
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup.py
. "/home/wslmtl/.xdg/data/rust/cargo/env"
