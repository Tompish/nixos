{pkgs, lib, ... }:
{
	environment.etc.".config/waybar".source =  pkgs.fetchFromGitHub {
	owner = "soaddevgit";
      repo = "WaybarTheme";
	  rev = "4d4cd74295f6a66631d8d04f9907d6502e48fd7c";
	  sha256 = "sha256-b87LBRVpQhpcjcdfgAHx94xfu4cXDOxB7xsQPy9NKaY=";
	};
}
