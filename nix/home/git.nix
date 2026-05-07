{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gh
    git
    lazygit
  ];
}

