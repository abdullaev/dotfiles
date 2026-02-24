{
  flake.modules.homeManager.neovim =
    {
      pkgs,
      lib,
      ...
    }:
    let
      vimConfig = lib.foldl' lib.recursiveUpdate { } [
        {
          viAlias = true;
          vimAlias = true;

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
            extraConfig = builtins.readFile ./_config/lua/catppuccin-extra-config.lua;
          };

          options = {
            scrolloff = 8;
            tabstop = 2;
            shiftwidth = 2;
            cursorline = true;
          };

          undoFile.enable = true;

          clipboard = {
            enable = true;
            providers.wl-copy.enable = true;
            registers = "unnamedplus";
          };

          lazy.enable = true;

          autocomplete.blink-cmp.enable = true;

          binds.whichKey = {
            enable = true;
            setupOpts = {
              preset = "helix";
            };
          };

          utility.direnv.enable = true;
          utility.nix-develop.enable = true;
          utility.motion.flash-nvim.enable = true;
          utility.smart-splits.enable = true;

          luaConfigPost = builtins.readFile ./_config/lua/lua-config-post.lua;
        }

        (import ./_config/lang.nix { inherit pkgs; })
        (import ./_config/git.nix)
        (import ./_config/mini.nix)
        (import ./_config/snacks.nix)
        (import ./_config/lualine.nix)
        (import ./_config/noice.nix)
        (import ./_config/keymaps.nix)
        (import ./_config/highlight.nix)
      ];
    in
    {
      programs.nvf = {
        enable = true;
        defaultEditor = true;
        settings.vim = vimConfig;
      };
    };
}
