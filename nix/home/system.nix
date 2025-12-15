{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xclip
    xremap
  ];

  xdg.configFile."xremap" = {
    source = ./system/xremap;
    recursive = true;
  };
  home.sessionVariables = {
  };
}

