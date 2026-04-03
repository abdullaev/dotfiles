{
  den,
  inputs,
  lib,
  ...
}:
let
  inherit (lib)
    mkDefault
    mkOption
    types
    ;
in
{
  den.schema.user = { user, ... }: {
    options = {
      fullName = mkOption {
        type = types.str;
        default = user.userName;
      };

      email = mkOption {
        type = types.str;
        default = "";
      };

      homeDirectory = mkOption {
        type = types.str;
        default = "/home/${user.userName}";
      };

      groups = mkOption {
        type = with types; listOf str;
        default = [ ];
      };

      passwordSecret = mkOption {
        type = with types; nullOr str;
        default = null;
      };

      authorizedKeys = mkOption {
        type = with types; listOf str;
        default = [ ];
      };

      shell = mkOption {
        type = with types; enum [ "bash" "zsh" "fish" ];
        default = "zsh";
      };

      linger = mkOption {
        type = types.bool;
        default = true;
      };

      dotfilesPath = mkOption {
        type = types.str;
        default = "${user.homeDirectory}/dotfiles";
      };

      gpg = mkOption {
        type = types.submodule {
          options = {
            enable = mkOption {
              type = types.bool;
              default = false;
            };

            signingKey = mkOption {
              type = with types; nullOr str;
              default = null;
            };

            signByDefault = mkOption {
              type = types.bool;
              default = false;
            };
          };
        };
        default = { };
      };
    };

    config.classes = mkDefault [ "homeManager" ];
  };

  den.default = {
    includes = [ den.provides.hostname ];

    nixos = {
      _module.args.inputs = inputs;

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [
          inputs.nvf.homeManagerModules.default
          inputs.plasma-manager.homeModules.plasma-manager
          inputs.catppuccin.homeModules.catppuccin
        ];
        backupFileExtension = "backup";
        overwriteBackup = true;
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };

    homeManager.programs.home-manager.enable = true;
  };
}
