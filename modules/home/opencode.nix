{ ... }:

let
  opencodeHostname = "127.0.0.1";
  opencodePort = 4096;
  opencodeUrl = "http://${opencodeHostname}:${toString opencodePort}";
in
{
  programs.opencode = {
    enable = true;

    web.enable = true;

    settings = {
      server = {
        port = opencodePort;
        hostname = opencodeHostname;
      };
    };
  };

  home.shellAliases = {
    oc = "opencode attach ${opencodeUrl} --dir \"$PWD\"";
  };
}
