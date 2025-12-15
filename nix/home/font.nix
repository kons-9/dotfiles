{ pkgs, config, ... }:

{
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        nerd-fonts.hack
        nerd-fonts.roboto-mono

        dejavu_fonts
        liberation_ttf
        jetbrains-mono
        noto-fonts
        ipaexfont
    ];
}

