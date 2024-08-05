#!/bin/bash
# latest version
sudo apt update && sudo apt upgrade -y

# install sub modules
sudo apt install -y git pkg-config libssl-dev curl wget libfuse2 unzip zsh gcc

# install nvim
# note: if cpu architecture is not x86_64, you should change the url
if [ "$(uname -m)" = "x86_64" ]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
else
    echo "cpu architecture is not x86_64"
    echo "please install nvim manually"
fi

if ! type python3 > /dev/null 2>&1; then
    sudo apt install -y python3
fi

sudo apt install -y firefox 
