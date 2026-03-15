{
  git = {
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
