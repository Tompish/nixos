{ config, pkgs, ... }:

{
	programs.discord.enable = true;

# changes in each release.
	home.stateVersion = "25.05";
}
