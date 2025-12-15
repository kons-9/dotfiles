{ config, pkgs, ... }:

{
  programs.tmux.enable = true;

  xdg.configFile."tmux" = {
    source = ./tmux;
    recursive = true;
  };
  home.sessionVariables = {
  };
}

