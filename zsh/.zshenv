
export XDG_CONFIG_HOME="$HOME/.xdg/config"
export XDG_DATA_HOME="$HOME/.xdg/data"
export XDG_STATE_HOME="$HOME/.xdg/state"
export XDG_CACHE_HOME="$HOME/.xdg/cache"

export ZDOTDIR=$XDG_CONFIG_HOME/zsh

export CARGO_HOME="$XDG_DATA_HOME/rust/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rust/rustup"
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup.py
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export SHELDON_CONFIG_DIR=$ZDOTDIR/sheldon
export SHELDON_CONFIG_FILE=$ZDOTDIR/sheldon/plugins.toml
export DENO_INSTALL="$XDG_DATA_HOME/deno"

# path setting
export PATH="$DENO_INSTALL/bin:$PATH"
[ -s "$CARGO_HOME/env" ] && \. "$CARGO_HOME/env"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
