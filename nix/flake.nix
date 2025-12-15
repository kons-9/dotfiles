{
  description = "dotfiles";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      # url = "github:nix-community/home-manager/release-23.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
    };
  in
  {
    homeConfigurations.default =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/home.nix ];
      };
  };
}

