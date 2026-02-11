{ config, pkgs, lib, isWsl, ... }:

{
  # Exclude xremap in WSL
  home.packages = lib.mkIf (!isWsl) (with pkgs; [
    xclip
    xremap
  ]);

  xdg.configFile."xremap" = {
    source = ./system/xremap;
    recursive = true;
  };

  home.sessionVariables = {
  };

  # Remove xremap service in WSL
  systemd.user.services =
    lib.mkIf (!isWsl) {
      xremap = {
        Unit = {
          Description = "xremap service";
          After = [ "default.target" ];
        };
        Service = {
          ExecStart = "${pkgs.xremap}/bin/xremap ${config.xdg.configHome}/xremap/config.yml";
          Restart = "on-failure";
          StandardOutput = "journal";
          StandardError = "journal";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
}

