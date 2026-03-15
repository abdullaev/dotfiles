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
            style = "auto";
            extraConfig = builtins.readFile ./_config/lua/catppuccin-extra-config.lua;
          };

          options = {
            scrolloff = 10;
            tabstop = 2;
            shiftwidth = 2;
            autoindent = true;
            cursorline = false;
            winborder = "rounded";
            complete = "";
            wildchar = 0;
            foldlevel = 99;
            foldlevelstart = 99;
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
        (import ./_config/git.nix)
        (import ./_config/languages.nix)
        (import ./_config/lsp.nix)
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
