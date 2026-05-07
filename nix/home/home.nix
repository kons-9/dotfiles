# home/home.nix
{ pkgs, config, ... }:

{
    home.username = "toshiki";
    home.homeDirectory = "/home/toshiki";

    home.stateVersion = "23.11";

    xdg.enable = true;
    xdg.configHome = "${config.home.homeDirectory}/.xdg/config";
    xdg.dataHome   = "${config.home.homeDirectory}/.xdg/data";
    xdg.cacheHome  = "${config.home.homeDirectory}/.xdg/cache";
    xdg.stateHome  = "${config.home.homeDirectory}/.xdg/state";

    imports = [
        ./zsh.nix
        ./gui.nix
        ./cli.nix
        ./lang.nix
        ./git.nix
        ./font.nix
        ./tmux.nix
        ./terminal.nix
        ./editor.nix
        ./system.nix
    ];
}
