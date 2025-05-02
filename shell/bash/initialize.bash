__makeSimlink() {
    local src="$1"
    local dest="$2"
    ln -sf "$src" "$dest"
    echo "Created symlink: $dest -> $src"
}

cd "$(dirname "$0")"
dirpath="$(pwd)/../.."

source "${dirpath}/shell/common/env.sh"

bashrc_source="${dirpath}/shell/bash/.bashrc"
bashrc_target="$HOME/.bashrc"
__makeSimlink $bashrc_source $bashrc_target

bash_aliases_source="${dirpath}/shell/bash/.bash_aliases"
bash_aliases_target="$HOME/.bash_aliases"
__makeSimlink $bash_aliases_source $bash_aliases_target

bash_profile_source="${dirpath}/shell/common/env.sh"
bash_profile_target="$HOME/.bash_profile"
__makeSimlink $bash_profile_source $bash_profile_target