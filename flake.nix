{
	description = "Dev Environment with Home Manager";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
	};

	outputs = { self, nixpkgs, home-manager };
		let 
			system = "x86_64-linux";
			pkgs = import nixpkgs { inherit system; };
		in
		{
			homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;

				home.username = builtins.getEnv "USER";
				home.homeDirectory = builtins.getEnv "HOME";

				home.packages = with pkgs; {
					wezterm
                    neovim
                    tmux
                    zsh
                    lazygit
                    git
                    gh
                    # langage
                    nvm
					nodejs
					python3
					rustc
					cargo
                    gcc
                    g++
                    # rust app
                    exa
                    fd
                    bat
                    ripgrep
                    zoxide
				}

				home.activation.generateZshrc = home-manager.lib.makeActivationScript {
					name = "generate-zshrc";
					text = builtins.readFile ./flake/generate-zshrc.sh;
				}
			};
			
		};
}
