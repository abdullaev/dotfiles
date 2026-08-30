{
  flake.modules.homeManager.herdr =
    {
      config,
      inputs,
      lib,
      pkgs,
      ...
    }:
    let
      palette =
        (lib.importJSON "${inputs.catppuccin-palette}/palette.json").${config.catppuccin.flavor}.colors;
      accent = palette.${config.catppuccin.accent}.hex;

      # The agent integrations are shims embedded in the herdr binary that report
      # the pane's agent session back over HERDR_SOCKET_PATH, so the agent panel
      # can track and resume it. `herdr integration install` drops them in place
      # imperatively and rewrites ~/.claude/settings.json, which home-manager owns
      # and links read-only — so unpack the shims from the packaged binary and wire
      # them up here instead. They stay in lockstep with the herdr package.
      integrations = pkgs.runCommand "herdr-integrations" { } ''
        export HOME="$NIX_BUILD_TOP/home"
        mkdir -p "$HOME/.claude" "$HOME/.config/opencode" "$out"

        herdr=${lib.getExe config.programs.herdr.package}
        "$herdr" integration install claude
        "$herdr" integration install opencode

        cp "$HOME/.claude/hooks/herdr-agent-state.sh" "$out/claude-agent-state.sh"
        cp "$HOME/.config/opencode/plugins/herdr-agent-state.js" "$out/opencode-agent-state.js"
        cp "$HOME/.config/opencode/herdr-tui-session.js" "$out/opencode-tui-session.js"
        cp "$HOME/.config/opencode/tui.jsonc" "$out/opencode-tui.jsonc"
      '';

      # `herdr integration status` looks for the hook at this exact path.
      claudeHook = ".claude/hooks/herdr-agent-state.sh";

      claudeHookCommand =
        "PATH=${lib.makeBinPath [ pkgs.python3 ]}\${PATH:+:$PATH} "
        + "bash '${config.home.homeDirectory}/${claudeHook}' session";
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
              surface_dim = palette.surface0.hex;
            };
          };

          update = {
            version_check = false;
          };

          keys = {
            prefix = "alt+w";
            switch_workspace = "prefix+shift+1..9";
            focus_agent = "prefix+alt+1..9";
          };

          ui = {
            inherit accent;
            agent_panel_sort = "priority";
            hide_tab_bar_when_single_tab = true;
            toast = {
              delivery = "system";
              clipboard.enabled = false;
            };
          };

          experimental = {
            kitty_graphics = true;
          };
        };
      };

      # `toast.delivery = "system"` runs `notify-send`, which lives in libnotify
      # and is not otherwise part of the closure. Without it herdr silently
      # falls back to showing nothing.
      home.packages = [ pkgs.libnotify ];

      programs.claude-code = lib.mkIf config.programs.claude-code.enable {
        settings.hooks.SessionStart = [
          {
            matcher = "*";
            hooks = [
              {
                type = "command";
                command = claudeHookCommand;
                timeout = 10;
              }
            ];
          }
        ];
      };

      home.file.${claudeHook} = lib.mkIf config.programs.claude-code.enable {
        source = "${integrations}/claude-agent-state.sh";
      };

      xdg.configFile = lib.mkIf config.programs.opencode.enable {
        "opencode/plugins/herdr-agent-state.js".source = "${integrations}/opencode-agent-state.js";
        "opencode/herdr-tui-session.js".source = "${integrations}/opencode-tui-session.js";
        "opencode/tui.jsonc".source = "${integrations}/opencode-tui.jsonc";
      };

      programs.fish.interactiveShellInit = ''
        if set -q HERDR_ENV; and test "$TERM" = xterm-256color
            set -gx TERM xterm-ghostty
        end
      '';
    };
}
