{
  git = {
    enable = true;

    git-conflict.enable = false;
    gitsigns.enable = false;
    hunk-nvim.enable = false;
    vim-fugitive.enable = false;

    neogit = {
      enable = true;
      mappings = {
        open = "<leader>gg";
        commit = "<leader>gc";
        pull = "<leader>gp";
        push = "<leader>gP";
      };
      setupOpts = {
        disable_hint = true;
        disable_context_highlighting = false;
        graph_style = "kitty";
        signs = {
          item = [
            ""
            ""
          ];
          section = [
            ""
            ""
          ];
        };
      };
    };
  };
}
