{ config, pkgs, ... }:

{

	imports = [
		./starship/starship.nix
	];

  home.username = "tdawg";
  home.homeDirectory = "/home/tdawg";


  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
	git

    neofetch
	cmatrix

    # archives
    zip
    unzip

	#LSPs
	rust-analyzer
	rustc
	rustPlatform.rustLibSrc
	lua-language-server

	#General compilers
	gcc
	cargo

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    eza # A modern replacement for ‘ls’
	bat
  ];

  programs.zoxide.enable = true;

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
	settings = {
		user = {
			name = "tompish";
			email = "euler.linder@gmail.com";
		};
	};
  };

  programs.fzf = {
	enable = true;
	enableZshIntegration = true;
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
	preset = "pastel-powerline";
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.kitty = {
    enable = true;
    # custom settings
    settings = {
		background_opacity = 0.85;
      };
    };

  programs.zsh = {
    enable = true;
	shellAliases = {
		ls = "eza";
		cat = "bat";
		cd = "z";
		tree = "eza --tree";
	};
	envExtra = ''
		if [ "$TMUX" = "" ]; then tmux; fi
		#emacs keybinds
		bindkey -e
		neofetch
	'';
  };

  programs.neovim = {
	  enable = true;
	  defaultEditor = true;
  };

  programs.tmux = {
	  enable = true;
	  prefix = "C-s";
	  keyMode = "vi";
	  baseIndex = 1;
	  clock24 = true;
	  sensibleOnTop = true;
	  terminal = "tmux-256color";
	  plugins = with pkgs; [
	  {
		  plugin = tmuxPlugins.catppuccin;
		  extraConfig = ''
			  set -g @catppuccin_flavor "mocha"
			  set -g @catppuccin_window_status_style "rounded"

			  set -g status-right-length 100
			  set -g status-left-length 100
			  set -g status-left ""
			  set -g status-right "#{E:@catppuccin_status_application}"
			  set -agF status-right "#{E:@catppuccin_status_cpu}"
			  set -ag status-right "#{E:@catppuccin_status_session}"
			  set -ag status-right "#{E:@catppuccin_status_uptime}"
			  set -agF status-right "#{E:@catppuccin_status_battery}"
			  '';
	  }
	  {
		  plugin = tmuxPlugins.yank;
	  }
	  ];
	  extraConfig = ''
			  bind '"' split-window -v -c "#{pane_current_path}"
			  bind '%' split-window -h -c "#{pane_current_path}"
	  '';
  };

  programs.yazi = {
	enable = true;
	enableZshIntegration = true;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
