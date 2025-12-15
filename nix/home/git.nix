{ config, pkgs, lib, ... }:

let
  gitDir = ./git;
in
{
  # Git コマンド自体をインストール
  home.packages = with pkgs; [
    gh
    git
    lazygit
  ];

  # ホームディレクトリに設定ファイルをコピー
  home.file = {
    ".gitconfig".source = "${gitDir}/config";
    ".gitignore_global".source = "${gitDir}/ignore";
  };

  # Git 設定で ignore を参照
  home.sessionVariables = {
    GIT_CONFIG_GLOBAL = "${config.home.homeDirectory}/.gitconfig";
    GIT_IGNORE_FILE = "${config.home.homeDirectory}/.gitignore_global";
  };
}

