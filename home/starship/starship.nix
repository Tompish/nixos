{ config, lib, pkgs, system, inputs, ... }:
let
	cfg = config.programs.starship;
	in {
		imports = [];

		options.programs.starship.preset = lib.mkOption {
			type = lib.types.str;
			default = "";
			example = "pastel-powerline";
		};


		config = lib.mkIf (cfg.enable && cfg.preset != "") {
			#if cfg.setting != {} then throw "Cannot stuff";
			home = {
				file.${cfg.configPath} = {
					source = if cfg.settings == {} then 
						./pastel-powerline.toml
						else
							throw "Starship cannot use both a preset and custom setting";
				};
			};
		};
	}
