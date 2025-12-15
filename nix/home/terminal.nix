{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wezterm
    alacritty
    mesa
    libGL
  ];

  xdg.configFile."wezterm" = {
    source = ./terminal/wezterm;
    recursive = true;
  };
  xdg.configFile."alacritty" = {
    source = ./terminal/alacritty;
    recursive = true;
  };
  home.sessionVariables = {
  };
}

