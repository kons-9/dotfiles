# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $CARGO_HOME/env

# install rust tools
cargo install cargo-binstall
cargo binstall exa -y
cargo binstall zoxide -y
cargo binstall fd-find -y
cargo binstall bat -y
cargo binstall ripgrep -y
cargo binstall sheldon -y

source initialize/sheldon.sh
