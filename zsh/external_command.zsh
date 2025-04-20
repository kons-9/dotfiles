# activations
[ -s "$CARGO_HOME/env" ] && \. "$CARGO_HOME/env"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

__execute external_command/zoxide.zsh
