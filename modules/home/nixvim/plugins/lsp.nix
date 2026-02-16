{
  enable = true;
  servers = {
    nixd = {
      enable = true;
      rootMarkers = [
        "flake.nix"
        ".git"
      ];
      settings = {
        formatting.command = [ "nixfmt" ];
        options = {
          nixos.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.vega.options";
          "home-manager".expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.vega.options.home-manager.users.type.getSubOptions []";
        };
      };
    };
  };
}
