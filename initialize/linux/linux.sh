# arch or ubuntu
git_base_dir=$(git rev-parse --show-toplevel)
this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

if [ -f /etc/arch-release ]; then
    # install arch linux
    source $this_dir/arch.sh
elif [ -f /etc/lsb-release ]; then
    # install ubuntu
    source $this_dir/ubuntu.sh
elif [ -f /etc/fedora-release ]; then
    #install fedora
    source $this_dir/fedora.sh
else
    echo "This script is only for Arch Linux, Ubuntu, or Fedora"
    exit 1
fi
