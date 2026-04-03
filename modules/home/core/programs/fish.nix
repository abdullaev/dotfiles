{
  den.aspects.fish = { user, ... }: {
    homeManager = {
      programs.fish = {
        enable = (user.shell or "zsh") == "fish";
        interactiveShellInit = ''
          set -g fish_greeting
        '';
      };

      catppuccin.fish.enable = true;
    };
  };
}
