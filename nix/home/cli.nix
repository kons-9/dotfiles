{ pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
    fd
    bat
    ripgrep
    zoxide
    sheldon
    tree
    # docker
  ];
}

