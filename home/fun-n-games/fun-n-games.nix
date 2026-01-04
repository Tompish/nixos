{ config, pkgs, ... }:

{
	programs.discord.enable = true;


  home.packages = with pkgs; [
	unityhub
	ntfs3g
  ];
# changes in each release.
	home.stateVersion = "25.05";
}
