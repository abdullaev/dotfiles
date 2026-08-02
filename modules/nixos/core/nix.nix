{
  flake.modules.nixos.nix =
    { config, inputs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      nix = {
        extraOptions = ''
          !include ${config.age.secrets.access-tokens.path}
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
