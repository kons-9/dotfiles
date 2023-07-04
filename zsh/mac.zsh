# install homebrew
if ! type brew > /dev/null 2>&1; then
  read "yn?Install all? [y/n]"
  case $yn in
    [Yy]* ) 
      __execute install_all_mac.zsh
      ;;
    [Nn]* ) ;;
    * ) __eecho "Please answer y or n.";;
  esac

  echo "brew not found"
  read "yn?Install homebrew? [y/n]"
  case $yn in
    [Yy]* ) /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";;
    [Nn]* ) __eecho "you need to install homebrew";;
    * ) __eecho "Please answer y or n.";;
  esac
fi

if !type nvim > /dev/null 2>&1; then
  read "yn?Install nvim? [y/n]"
  case $yn in
    [Yy]* ) 
      brew install neovim
      ;;
    [Nn]* ) ;;
    * ) __eecho "Please answer y or n.";;
  esac
fi


# install rustup
source $CARGO_HOME/env
if ! type cargo > /dev/null 2>&1; then
  echo "cargo not found"
  read "yn?Install rustup with brew? [y/n]"
  case $yn in
    [Yy]* ) 
      brew install rustup
      rustup-init
      source "$CARGO_HOME/env"
      cargo install cargo-binstall
      brew install pkg-config
      brew install openssl
      ;;
    [Nn]* ) 
      read "yn?Install rustup directly? [y/n]"
      case $yn in
        [Yy]* ) 
          curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
          source "$CARGO_HOME/env"
          ;;
        [Nn]* ) 
          __eecho "you need rustup";;
        * ) 
          __eecho "Please answer y or n.";;
      esac
    ;;
		
    * ) __eecho "Please answer y or n.";;
  esac
fi
