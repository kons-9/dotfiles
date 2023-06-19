__check_and_install_with_cargo zoxide
__check_and_install_with_cargo bat
__check_and_install_with_cargo exa
__check_and_install_with_cargo fd
__check_and_install_with_cargo ripgrep rg

__execute external_command/zoxide.zsh

# connect external command to default
alias cd='z'
alias ls="exa"
alias cat='bat'
alias find='fd'
alias rg='rg --hidden'

