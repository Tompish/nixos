# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, system, inputs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

#Allow unfree for discord and steam
	nixpkgs.config.allowUnfree = true;

# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "tdawgos"; # Define your hostname.
		networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

		nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Set your time zone.
	time.timeZone = "Europe/Stockholm";


#When using niri flake, the rust unit test causes the nixos-build process to abort.
#Hopefully I can remove this in the future
	nixpkgs.overlays = [
		(_: _: {
		 niri = inputs.niri-flake.packages.${system}.niri.overrideAttrs (_: {doCheck = false;});
		 })
		 (_: prev: {
			sddm-astronaut = prev.sddm-astronaut.override { embeddedTheme = "hyprland_kath"; };
		 })
	];
# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

	services.displayManager.sddm = {
		enable = true;
		wayland = {
			enable = true;
		};
		theme = "sddm-astronaut-theme";
		extraPackages = with pkgs; [
			kdePackages.qtmultimedia
			sddm-astronaut
		];
	};

	programs.firefox.enable = true;

	programs.niri = {
		enable = true;
	};

	programs.steam.enable = true;
	programs.zsh.enable = true;

# Enable sound.
# services.pulseaudio.enable = true;
# OR
# services.pipewire = {
#   enable = true;
#   pulse.enable = true;
# };

# Enable touchpad support (enabled default in most desktopManager).
# services.libinput.enable = true;

	users.users.tdawg = {
		isNormalUser = true;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
		shell = pkgs.zsh;
	};

	environment.systemPackages = with pkgs; [
		vim 
			wget
			kitty

			home-manager

#Wayland related stuff
			gnome-keyring
			xdg-desktop-portal-gtk
			xdg-desktop-portal-gnome
			fuzzel
			mako
			waybar
			xwayland-satellite
			wl-clipboard
			swaylock
			swaybg

#sddm theme
			sddm-astronaut
			kdePackages.qtmultimedia

			btop
			htop
			];

	fonts.packages = with pkgs; [
		gohufont
			nerd-fonts.proggy-clean-tt
			nerd-fonts.jetbrains-mono
	];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };


# Enable the OpenSSH daemon.
	services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;


#TLDR; DO NOT TOUCH!
	system.stateVersion = "25.05";

}

