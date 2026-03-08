{ lib, inputs }:
let
  inherit (lib)
    mkOption
    types
    ;
in
{ config, name, ... }:
{
  options = {
    users = mkOption {
      type =
        with types;
        attrsOf (
          submodule (
            {
              config,
              name,
              ...
            }:
            {
              options = {
                fullName = mkOption {
                  type = types.str;
                };

                email = mkOption {
                  type = types.str;
                };

                homeDirectory = mkOption {
                  type = types.str;
                  default = "/home/${name}";
                };

                groups = mkOption {
                  type = with types; listOf str;
                  default = [
                    "networkmanager"
                  ];
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
                  type =
                    with types;
                    enum [
                      "bash"
                      "zsh"
                      "fish"
                    ];
                  default = "zsh";
                };

                linger = mkOption {
                  type = types.bool;
                  default = true;
                };

                enableHomeManager = mkOption {
                  type = types.bool;
                  default = true;
                };

                homeManagerModules = mkOption {
                  type = with types; nullOr (listOf deferredModule);
                  default = null;
                };

                extraHomeManagerModules = mkOption {
                  type = with types; listOf deferredModule;
                  default = [ ];
                };

                dotfilesPath = mkOption {
                  type = types.str;
                  default = "${config.homeDirectory}/dotfiles-nix";
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
             }
           )
         );
      default = { };
    };

    system = mkOption {
      type = types.str;
      default = "x86_64-linux";
    };

    modules = mkOption {
      type = with types; listOf deferredModule;
      default = [ ];
    };

    extraSpecialArgs = mkOption {
      type = with types; attrsOf anything;
      default = { };
    };

    specialArgs = mkOption {
      type = with types; attrsOf anything;
      readOnly = true;
    };

    finalPackage = mkOption {
      type = types.package;
    };
  };

  config.specialArgs = {
    inherit inputs;
    hostName = name;
    inherit (config)
      users
      ;
  }
  // config.extraSpecialArgs;
}
