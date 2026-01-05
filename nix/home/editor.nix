{ config, pkgs, ... }:

{
    programs.vscode = {
      enable = true;
    };

  home.packages = with pkgs; [
    neovim
  ];

  xdg.configFile."nvim" = {
    source = ./editor/nvim;
    recursive = true;
  };

  xdg.configFile."Code/User" = {
    source = ./editor/vscode;
    recursive = true;
  };
  home.sessionVariables = {
  };
}

