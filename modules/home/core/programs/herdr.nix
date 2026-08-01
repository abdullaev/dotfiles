{
  flake.modules.homeManager.herdr =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      palette =
        (lib.importJSON "${config.catppuccin.sources.palette}/palette.json")
        .${config.catppuccin.flavor}.colors;

      accent = palette.${config.catppuccin.accent}.hex;
    in
    {
      programs.herdr = {
        enable = true;
        package = pkgs.herdr;

        settings = {
          onboarding = false;

          theme = {
            name = "catppuccin";
            custom = {
              inherit accent;
            };
          };

          update = {
            version_check = false;
          };

          keys = {
            prefix = "alt+w";
            switch_workspace = "prefix+shift+1..9";
            next_workspace = "prefix+shift+j";
            previous_workspace = "prefix+shift+k";
          };

          ui = {
            inherit accent;
            agent_panel_sort = "priority";
            hide_tab_bar_when_single_tab = true;
            toast = {
              delivery = "terminal";
              clipboard.enabled = false;
            };
          };

          experimental = {
            kitty_graphics = true;
            pane_history = true;
          };
        };
      };

      programs.fish.interactiveShellInit = ''
        if set -q HERDR_ENV; and test "$TERM" = xterm-256color
            set -gx TERM xterm-ghostty
        end
      '';

      programs.zsh.initContent = ''
        if [[ -n "$HERDR_ENV" && "$TERM" == "xterm-256color" ]]; then
          export TERM=xterm-ghostty
        fi
      '';
    };
}
