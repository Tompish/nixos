{ config, pkgs, ... }:

{

	home.file."/.config/waybar".source = pkgs.fetchFromGitHub {
		owner = "soaddevgit";
		repo = "WaybarTheme";
		rev = "4d4cd74295f6a66631d8d04f9907d6502e48fd7c";
		sha256 = "sha256-b87LBRVpQhpcjcdfgAHx94xfu4cXDOxB7xsQPy9NKaY=";
	};

	home.file."/.config/fuzzel/themes".source = pkgs.fetchFromGitHub {
		owner = "catppuccin";
		repo = "fuzzel";
		rev = "main";
		sha256 = "sha256-XpItMGsYq4XvLT+7OJ9YRILfd/9RG1GMuO6J4hSGepg=";
	} + "/themes";


	programs.fuzzel = {
		enable = true;
		settings = {
			main =
			{ 
				include = "~/.config/fuzzel/themes/catppuccin-mocha/pink.ini";
			};
		};
	};

# changes in each release.
	home.stateVersion = "25.05";
}
