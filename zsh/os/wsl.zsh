# if you have installed windows version of nvim, cargo, git, python, node, you can use this file to make them work in wsl
local flag=true

function __apt_update() {
  sudo apt update
  sudo apt upgrade
}
