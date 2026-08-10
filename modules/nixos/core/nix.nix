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
          extra-substituters = [
            "https://abdullaev-dotfiles.cachix.org"
            "https://devenv.cachix.org"
          ];
          extra-trusted-public-keys = [
            "abdullaev-dotfiles.cachix.org-1:ojAEcXkl3aLb8O7Cyt8JOk3yBljFwf/jcUC58Ha3KQ0="
            "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          ];
        };

        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 14d";
        };
      };
    };
}
