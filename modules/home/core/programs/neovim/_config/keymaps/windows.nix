[
  {
    mode = [
      "n"
      "t"
      "i"
      "x"
    ];
    key = "<A-m>";
    action = "function() Snacks.zen.zoom() end";
    lua = true;
    desc = "Toggle zoom";
  }
  {
    mode = [
      "n"
      "t"
      "i"
      "x"
    ];
    key = "<A-z>";
    action = "function() Snacks.zen.zen() end";
    lua = true;
    desc = "Toggle zen";
  }
  {
    mode = "n";
    key = "<leader>q";
    action = "<cmd>qa!<CR>";
    desc = "Quit all";
  }
  {
    mode = "n";
    key = "<leader>w";
    action = "<cmd>wa<CR>";
    desc = "Write all";
  }
]
