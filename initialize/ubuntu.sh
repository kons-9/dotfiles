#!/bin/bash
if [ "$NO_SUDO" != "1" ]; then
    sudo apt update && sudo apt upgrade -y
    # install sub modules
    sudo apt install -y git libssl-dev curl zsh docker
fi

