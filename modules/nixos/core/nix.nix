{
  flake.modules.nixos.nix =
    { config, inputs, ... }:
    {
      sops.secrets.nix-access-tokens = {
        sopsFile = ../../../secrets/shared.yaml;
        group = "wheel";
        mode = "0440";
      };

      nixpkgs.config.allowUnfree = true;
      nix = {
        extraOptions = ''
          !include ${config.sops.secrets.nix-access-tokens.path}
        '';

        registry.nixpkgs.flake = inputs.nixpkgs;
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          auto-optimise-store = true;
        };

        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 14d";
        };
      };
    };
}
