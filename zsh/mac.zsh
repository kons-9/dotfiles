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
if ! type cargo > /dev/null 2>&1; then
  echo "cargo not found"
  read "yn?Install rustup with brew? [y/n]"
  case $yn in
    [Yy]* ) 
      brew install rustup
      rustup-init
      source "$HOME/.cargo/env"
      cargo install cargo-binstall
      brew install pkg-config
      brew install openssl
      ;;
    [Nn]* ) 
      read "yn?Install rustup directly? [y/n]"
      case $yn in
        [Yy]* ) 
          curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
          source "$HOME/.cargo/env"
          ;;
        [Nn]* ) 
          __eecho "you need rustup";;
        * ) 
          __eecho "Please answer y or n.";;
      esac
    ;;
		
    * ) __eecho "Please answer y or n.";;
  esac

else 
  source "$HOME/.cargo/env"
fi

# c compiler
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export LDFLAGS="-L/usr/local/opt/llvm/include"

# path setting
export PATH="$PATH:$HOME/Documents2/llvm-project/build/bin"
export PATH="$PATH:/usr/local/Cellar/dosfstools/4.2/sbin"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export PATH="/usr/local/opt/llvm/bin:$PATH"
