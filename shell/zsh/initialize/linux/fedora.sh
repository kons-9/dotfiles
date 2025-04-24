if [ "$NO_SUDO" != "1" ]; then
    sudo dnf install -y neovim zsh git gcc
fi
