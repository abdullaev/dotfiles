{
  flake.modules.homeManager.starship = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;

      settings = {
        add_newline = false;
        format = "$directory$git_branch$nix_shell$character";

        line_break = {
          disabled = true;
        };

        directory = {
          style = "blue";
          format = "[$path]($style) ";
          truncation_length = 4;
          truncation_symbol = "…/";
        };

        git_branch = {
          style = "mauve";
          format = "on [$branch]($style) ";
          only_attached = false;
        };

        nix_shell = {
          impure_msg = "[impure](bold red)";
          pure_msg = "[pure](bold green)";
          unknown_msg = "[unknown](bold yellow)";
          format = "via [ $state()](bold blue) ";
        };

        character = {
          success_symbol = "[∙](green)";
          error_symbol = "[∙](red)";
          format = "$symbol ";
        };
      };
    };

    catppuccin.starship.enable = true;
  };
}
