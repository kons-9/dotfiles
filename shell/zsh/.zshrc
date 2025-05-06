#!/bin/zsh
# zsh setting
function __execute () {
  source $ZDOTDIR/$1
}
__execute util.zsh
__execute external_command.zsh

__execute automatic_initialization.zsh

__execute update_dotfiles.zsh

# local setting
__execute generated/zshrc.local

# depends on os
__execute os/os.zsh

# common
__execute plugin.zsh
__execute prompt.zsh
__execute alias.zsh
__execute misc.zsh

export NVM_DIR="$HOME/.xdg/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
