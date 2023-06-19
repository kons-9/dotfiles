__check_and_install_with_cargo zoxide
__check_and_install_with_cargo bat
__check_and_install_with_cargo exa
__check_and_install_with_cargo fd-find fd
__check_and_install_with_cargo ripgrep rg

__execute external_command/zoxide.zsh

# connect external command to default
__map cd 'z'
__map ls 'exa'
__map cat 'bat'
__map find 'fd'
__map rg 'rg --hidden'

