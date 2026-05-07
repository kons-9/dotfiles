{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wezterm
    alacritty
    mesa
    libGL
  ];
}

