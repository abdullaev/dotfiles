{ pkgs, ... }:

{
  home.packages = with pkgs; [
    code-cursor-fhs
  ];

  home.file.".config/Cursor/User/settings.json".source = ../../config/Cursor/User/settings.json;
}
