{
  flake.modules.homeManager.neovim = {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      globals.mapleader = " ";
      globals.maplocalleader = " ";

      opts = {
        number = true;
        relativenumber = true;
        termguicolors = true;
        mouse = "a";
        clipboard = "unnamedplus";
        breakindent = true;
        undofile = true;
        ignorecase = true;
        smartcase = true;
        signcolumn = "yes";
        updatetime = 250;
        timeoutlen = 300;
        splitright = true;
        splitbelow = true;
        cursorline = true;
        scrolloff = 8;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        smartindent = true;
      };

      colorschemes.catppuccin = {
        enable = true;
        settings.flavour = "mocha";
      };

      keymaps = import ./_config/keymaps.nix;

      plugins = import ./_config/plugins;
    };
  };
}
