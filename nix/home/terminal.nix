{ inputs, config, pkgs, ... }:


let
  weztermAppImage = pkgs.fetchurl {
    url = "https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/WezTerm-20240203-110809-5046fc22-Ubuntu20.04.AppImage";
    # sha256 = "1w30djaqzy13cd22kmz8k6ang2k0mq6mwjzrsk2748kd0w3hl09l";
    sha256 = "1pg5qj0g2slq6z9xl1hszjxr97n7qsxr009av92cjx9fl4h3hgam";
    executable = true;
  };
in
{
    # programs.wezterm = {
    #     enable = true;
    #     package = inputs.wezterm.packages.${pkgs.system}.default;
    # };
  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "wezterm" ''
      exec "${weztermAppImage}" "$@"
      '')
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

