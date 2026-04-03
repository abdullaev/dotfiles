{
  den.aspects.nix.nixos = { config, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      nix = {
        extraOptions = ''
          !include ${config.age.secrets.access-tokens.path}
        '';

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
