#!/bin/bash
# configure environment variables, which is written in .zshenv
git_base_dir=$(git rev-parse --show-toplevel)

source $(git_base_dir)/zsh/.zshenv

source $(git_base_dir)/initialize/linux/linux.sh

# common
source $(git_base_dir)/initialize/rust.sh
source $(git_base_dir)/initialize/nvm.sh
