{
  flake.modules.homeManager.fish =
    { user, ... }:
    {
      programs.fish = {
        enable = user.shell == "fish";
        interactiveShellInit = ''
          set -g fish_greeting
        '';
      };

      catppuccin.fish.enable = true;
    };
}
