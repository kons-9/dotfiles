# activations
[ -s "$CARGO_HOME/env" ] && \. "$CARGO_HOME/env"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use node # This loads nvm
[ -s "$XDG_DATA_HOME/deno/env" ] && \. "$XDG_DATA_HOME/deno/env"

__execute external_command/zoxide.zsh
