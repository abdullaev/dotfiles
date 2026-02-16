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

    keymaps = [
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        options = {
          desc = "Clear search highlight";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          desc = "Find files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options = {
          desc = "Grep files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options = {
          desc = "Find buffers";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options = {
          desc = "Find help";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<CR>";
        options = {
          desc = "Recent files";
          silent = true;
        };
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;
      telescope.enable = true;
      which-key.enable = true;

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
