{
  den.aspects.neovim.homeManager = {
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
            style = "auto";
            extraConfig = builtins.readFile ./_config/lua/catppuccin-extra-config.lua;
          };

          options = {
            cursorline = false;

            scrolloff = 10;
            sidescrolloff = 5;

            tabstop = 2;
            shiftwidth = 2;
            softtabstop = 2;
            expandtab = true;
            smartindent = true;
            autoindent = true;

            ignorecase = true;
            smartcase = true;

            foldlevel = 99;
            foldlevelstart = 99;

            winborder = "rounded";
            complete = "";
            wildchar = 0;
          };

          undoFile.enable = true;

          clipboard = {
            enable = true;
            providers.wl-copy.enable = true;
            registers = "unnamedplus";
          };

          luaConfigPost = builtins.readFile ./_config/lua/lua-config-post.lua;
        }

        (import ./_config/keymaps)
        (import ./_config/autocomplete.nix { inherit lib; })
        (import ./_config/diagnostics.nix)
        (import ./_config/formatters.nix { inherit pkgs lib; })
        (import ./_config/git.nix)
        (import ./_config/languages.nix)
        (import ./_config/lsp { inherit pkgs lib; })
        (import ./_config/lua-config-rc.nix { inherit pkgs lib; })
        (import ./_config/lualine.nix)
        (import ./_config/mini.nix)
        (import ./_config/snacks.nix { inherit pkgs lib; })
        (import ./_config/treesitter.nix { inherit pkgs; })
        (import ./_config/ui.nix)
        (import ./_config/utility.nix)
        (import ./_config/binds.nix)
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
