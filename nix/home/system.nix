{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    xclip
    xremap
  ];

  systemd.user.services.xremap = {
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
}

