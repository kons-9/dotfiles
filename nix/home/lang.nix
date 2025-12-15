
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
  xdg.configFile."python" = {
    source = ./lang/python;
    recursive = true;
  };
  xdg.configFile.".clang-format" = {
    source = ./lang/clang/.clang-format;
    recursive = true;
  };
  home.sessionVariables = {
    CARGO_HOME   = "$XDG_DATA_HOME/rust/cargo";
    RUSTUP_HOME  = "$XDG_DATA_HOME/rust/rustup";
    PYTHONSTARTUP = "$XDG_CONFIG_HOME/python/startup.py";
    NVM_DIR       = "$XDG_CONFIG_HOME/nvm";
    DENO_INSTALL = "$XDG_DATA_HOME/deno";
    VOLTA_BIN = "$HOME/.volta/bin";
  };
  home.sessionPath = [
    "$DENO_INSTALL/bin"
    "$VOLTA_BIN"
  ];
}

