{
  flake.modules.homeManager.zsh =
    { config, user, ... }:
    {
      programs.zsh = {
        enable = user.shell == "zsh";
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        history = {
          path = "${config.home.homeDirectory}/.zsh_history";
          size = 50000;
          save = 50000;
          share = true;
          ignoreSpace = true;
          expireDuplicatesFirst = true;
          extended = true;
        };

        setOptions = [
          "HIST_FCNTL_LOCK"
          "HIST_IGNORE_ALL_DUPS"
          "HIST_SAVE_NO_DUPS"
          "HIST_FIND_NO_DUPS"
          "HIST_REDUCE_BLANKS"
          "AUTO_MENU"
          "MENU_COMPLETE"
          "AUTO_CD"
          "INTERACTIVE_COMMENTS"
        ];
      };
    };
}
