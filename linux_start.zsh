sudo apt update -y && sudo apt upgrade -y
sudo apt install -y zsh git curl wget 
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

zsh start.zsh -y
restart

