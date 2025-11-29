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
# NixOS configuration entrypoint
# Available through 'nixos-rebuild --flake .#your-hostname'
		nixosConfigurations = {
			tdawgos = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit system inputs; };
# > Our main nixos configuration file <
				modules = [
					./tdawgos/configuration.nix
						inputs.niri-flake.nixosModules.niri
						#home-manager.nixosModules.home-manager
						#{
          				#  home-manager.useGlobalPkgs = true;
          				#  home-manager.useUserPackages = true;
          				#  home-manager.users.tdawg = ./tdawgos/config/configfilemanager.nix;
          				#}
				];
			};
		};

		#I want to have two separate home managers, one for handling the OS specific config files,
		#such as compositor, displaymanager etc, and one home manager for 
		#developer tools configs, so that it's portable regardless of OS (for work)
		homeConfigurations = {
			tdawg = home-manager.lib.homeManagerConfiguration {
				pkgs = pkgs;#"${system}"; # FIXME replace x86_64-linux with your architecure 
				extraSpecialArgs = {inherit inputs;};
				modules = [
					./home/home.nix
					./home/os_specific.nix
				];
			};
		};
	};
}
