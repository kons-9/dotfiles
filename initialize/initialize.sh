#!/bin/bash
# configure environment variables, which is written in .zshenv
source zsh/.zshenv

source initialize/linux.sh

# common
source initialize/rust.sh
source initialize/nvm.sh
source initialize/dictionary.sh
