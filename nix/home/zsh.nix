{ pkgs, ... }:

{
  programs.zsh.enable = true;

  home.packages = with pkgs; [
    sheldon
  ];
}

