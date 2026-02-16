{ ... }:

{
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

    keymaps = import ./keymaps.nix;

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;
      telescope.enable = true;
      which-key.enable = true;

      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add.text = "▌";
            change.text = "▌";
            delete.text = "▌";
            topdelete.text = "▌";
            changedelete.text = "▌";
            untracked.text = "▌";
          };
          signs_staged = {
            add.text = "▌";
            change.text = "▌";
            delete.text = "▌";
            topdelete.text = "▌";
            changedelete.text = "▌";
            untracked.text = "▌";
          };
          signs_staged_enable = true;
          signcolumn = true;
          numhl = false;
          linehl = false;
          current_line_blame = false;
        };
      };

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
    };
  };
}
