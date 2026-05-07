
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    rustc
    cargo
    volta
    python3
    uv
    go
    gcc
  ];
}

