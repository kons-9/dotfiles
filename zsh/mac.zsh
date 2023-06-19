# install homebrew
if ! type brew > /dev/null 2>&1; then
  echo "brew not found"
  read "yn?Install homebrew? [y/n]"
  case $yn in
    [Yy]* ) /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; break;;
    [Nn]* ) eecho "you need to install homebrew";;
    * ) eecho "Please answer y or n.";;
  esac
fi

# install rustup
if ! type cargo > /dev/null 2>&1; then
  echo "cargo not found"
  read "yn?Install rustup with brew? [y/n]"
  case $yn in
    [Yy]* ) brew install rustup;;
    [Nn]* ) eecho "you need rustup"; break;;
    * ) eecho "Please answer y or n."; break;;
  esac

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
