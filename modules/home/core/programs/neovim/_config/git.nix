{
  git = {
    enable = true;
    git-conflict.enable = true;
    gitsigns.enable = false;
    hunk-nvim.enable = false;

    neogit = {
      enable = true;
      mappings = {
        open = "<leader>gg";
        commit = "<leader>gc";
        pull = "<leader>gp";
        push = "<leader>gP";
      };
    };
  };
}
