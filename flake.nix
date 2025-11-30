{
	description = "This OS took the red pill";

	inputs = {
# Nixpkgs
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		niri-flake.url = "github:sodiboo/niri-flake";
		niri-flake.inputs.nixpkgs.follows = "nixpkgs";
# Home manager
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs:
		let
		system = "x86_64-linux";
	pkgs = import nixpkgs {
		inherit system;

		config = {
			allowUnfree = true;
		};
	};
	in {
		nixosConfigurations = {
			tdawgos = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit system inputs; };
				modules = [
					./tdawgos/configuration.nix
					inputs.niri-flake.nixosModules.niri
				];
			};
		};

		homeConfigurations = {
			tdawg = home-manager.lib.homeManagerConfiguration {
				pkgs = pkgs;#"${system}"; # FIXME replace x86_64-linux with your architecure 
				extraSpecialArgs = {inherit inputs;};
				modules = [
					#All config files and most programs for my dev environment
					./home/develop/develop.nix
					#config files for OS related stuff, like Niri, waybar etc.
					./home/os-configs/os-config.nix
					#Programs for entertainment, like steam, discord etc
					./home/fun-n-games/fun-n-games.nix
				];
			};
		};
	};
}
