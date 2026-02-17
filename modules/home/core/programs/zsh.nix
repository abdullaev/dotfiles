{
  flake.modules.homeManager.zsh =
    { config, user, ... }:
    {
      programs.zsh = {
        enable = user.shell == "zsh";
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        completionInit = ''
          zmodload zsh/complist
          zstyle ':completion:*' menu select
        '';

        history = {
          path = "${config.home.homeDirectory}/.zsh_history";
          size = 50000;
          save = 50000;
          share = true;
          ignoreDups = true;
          ignoreSpace = true;
          expireDuplicatesFirst = true;
          extended = true;
        };

        setOptions = [
          "APPEND_HISTORY"
          "INC_APPEND_HISTORY"
          "HIST_FCNTL_LOCK"
          "HIST_IGNORE_ALL_DUPS"
          "HIST_SAVE_NO_DUPS"
          "HIST_FIND_NO_DUPS"
          "HIST_REDUCE_BLANKS"
          "SHARE_HISTORY"
          "AUTO_MENU"
          "MENU_COMPLETE"
          "AUTO_CD"
          "INTERACTIVE_COMMENTS"
        ];
      };
    };
}
