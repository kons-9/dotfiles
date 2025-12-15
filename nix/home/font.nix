{ pkgs, ... }:

{
    home.packages = with pkgs; [
        dejavu_fonts
        liberation_ttf
        jetbrains-mono
        noto-fonts
        ipaexfont
    ];
}

