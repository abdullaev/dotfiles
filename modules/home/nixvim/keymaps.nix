[
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
  {
    mode = "n";
    key = "<leader>fc";
    action = "<cmd>Telescope git_status<CR>";
    options = {
      desc = "Git changes";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>hs";
    action = "<cmd>Gitsigns stage_hunk<CR>";
    options = {
      desc = "Stage hunk";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>hu";
    action = "<cmd>Gitsigns undo_stage_hunk<CR>";
    options = {
      desc = "Unstage hunk";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>hr";
    action = "<cmd>Gitsigns reset_hunk<CR>";
    options = {
      desc = "Reset hunk";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>hS";
    action = "<cmd>Gitsigns stage_buffer<CR>";
    options = {
      desc = "Stage buffer";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>hR";
    action = "<cmd>Gitsigns reset_buffer<CR>";
    options = {
      desc = "Reset buffer";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>hp";
    action = "<cmd>Gitsigns preview_hunk<CR>";
    options = {
      desc = "Preview hunk";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>hb";
    action = "<cmd>Gitsigns blame_line<CR>";
    options = {
      desc = "Blame line";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>hB";
    action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
    options = {
      desc = "Toggle line blame";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>hd";
    action = "<cmd>Gitsigns diffthis<CR>";
    options = {
      desc = "Diff this";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "]h";
    action = "<cmd>Gitsigns next_hunk<CR>";
    options = {
      desc = "Next hunk";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "[h";
    action = "<cmd>Gitsigns prev_hunk<CR>";
    options = {
      desc = "Previous hunk";
      silent = true;
    };
  }
]
