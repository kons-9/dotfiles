if [ "$NO_SUDO" != "1" ]; then
    sudo pacman -Syu
    sudo pacman -S --noconfirm \
        git pkg-config openssl curl wget fuse2 unzip zsh gcc neovim
fi
