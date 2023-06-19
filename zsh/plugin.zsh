__check_and_install_with_cargo sheldon

# sheldon makes plugins.toml under $XDG_CONFIG_HOME/sheldon(default)
export SHELDON_CONFIG_DIR=$ZDOTDIR/sheldon
export SHELDON_CONFIG_FILE=$ZDOTDIR/sheldon/plugins.toml

# init config file
if [ ! -d $SHELDON_CONFIG_DIR ]; then
  echo make sheldon config directory
  sheldon init --shell zsh
  sheldon add zsh-history-substring-search --github zsh-users/zsh-history-substring-search
  sheldon add zsh-autosuggestions --github zsh-users/zsh-autosuggestions
  sheldon add zsh-256color --github chrissicool/zsh-256color
  sheldon add zsh-syntax-highlighting --github zsh-users/zsh-syntax-highlighting
  sheldon add gitstatus --github romkatv/gitstatus
fi

# a file which is called by .zshrc has argument, so we need to flush it because gitstatus use it, and this feature is unexpected.
1=
eval "$(sheldon source)"
