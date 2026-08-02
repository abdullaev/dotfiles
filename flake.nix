{
  description = "NixOS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree = {
      url = "github:vic/import-tree";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.systems.follows = "systems";
      inputs.darwin.follows = "";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.treefmt-nix.follows = "treefmt-nix";
      inputs.systems.follows = "systems";
    };
    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };
    mattpocock-skills = {
      url = "github:mattpocock/skills";
      flake = false;
    };
    obsidian-skills = {
      url = "github:kepano/obsidian-skills";
      flake = false;
    };
    ghostty-cursor-shaders = {
      url = "github:sahaj-b/ghostty-cursor-shaders";
      flake = false;
    };
    pragmata-pro = {
      url = "git+ssh://git@github.com/abdullaev/font-pragmata-pro.git";
      flake = false;
    };
    catppuccin-aseprite-mocha = {
      url = "file+https://github.com/catppuccin/aseprite/releases/download/v1.2.1/catppuccin-theme-mocha.aseprite-extension";
      flake = false;
    };
    catppuccin-aseprite-latte = {
      url = "file+https://github.com/catppuccin/aseprite/releases/download/v1.2.1/catppuccin-theme-latte.aseprite-extension";
      flake = false;
    };
    ru-ip-list = {
      url = "file+https://www.ipdeny.com/ipblocks/data/countries/ru.zone";
      flake = false;
    };
    ru-ip-list-v6 = {
      url = "file+https://www.ipdeny.com/ipv6/ipaddresses/blocks/ru.zone";
      flake = false;
    };
    russian-trusted-root-ca = {
      url = "file+https://gu-st.ru/content/Other/doc/russian_trusted_root_ca.cer";
      flake = false;
    };
  };

  outputs =
    inputs@{
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
