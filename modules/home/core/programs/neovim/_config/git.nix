{ pkgs, lib }:
{
  lazy.plugins.neogit.package = lib.mkForce pkgs.vimPlugins.neogit;

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
        treesitter_diff_highlight = true;
        word_diff_highlight = true;
        disable_hint = true;
        disable_context_highlighting = false;
        console_timeout = 15000;
        graph_style = "unicode";
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
