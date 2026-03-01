{
  git = {
    enable = true;
    git-conflict.enable = true;
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
        disable_context_highlighting = true;
        signs = {
          hunk = [
            ""
            ""
          ];
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
