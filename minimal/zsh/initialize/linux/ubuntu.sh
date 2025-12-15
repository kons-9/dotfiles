#!/bin/bash
# latest version
# if NO_SUDO is not set, execute it
if [ "$NO_SUDO" != "1" ]; then
    sudo apt update && sudo apt upgrade -y
    # install sub modules
    sudo apt install -y git pkg-config libssl-dev curl wget libfuse2 unzip zsh gcc python3

    # install nvim
    # note: if cpu architecture is not x86_64, you should change the url
    if [ "$(uname -m)" = "x86_64" ]; then
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
        chmod u+x nvim-linux-x86_64.appimage
        sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
    else
        echo "cpu architecture is not x86_64"
        echo "please install nvim manually"
    fi
fi

