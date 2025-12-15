# home/home.nix
{ pkgs, config, ... }:

{
    # home.username = builtins.getEnv "USER";
    # home.homeDirectory = builtins.getEnv "HOME";
    home.username = "toshiki";
    home.homeDirectory = "/home/toshiki";

    home.stateVersion = "23.11"; # 初回は固定

    xdg.enable=true;
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
