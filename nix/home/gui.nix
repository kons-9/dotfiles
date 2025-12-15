{ pkgs, ... }:

{
  # GUI 関連パッケージをまとめる
  home.packages = with pkgs; [
    firefox
    discord
    spotify  # unfree パッケージなので flake.nix 側で allowUnfree = true にしておく
    vscode
  ];
}

