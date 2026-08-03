{
  flake.modules.homeManager.firefox = {
    programs.firefox.profiles.default.handlers = {
      # action 3 = open in Firefox, 2 = helper app, 4 = system default.
      mimeTypes = {
        "application/pdf" = {
          action = 3;
          extensions = [ "pdf" ];
        };
        "image/webp" = {
          action = 3;
          extensions = [ "webp" ];
        };
        "image/avif" = {
          action = 3;
          extensions = [ "avif" ];
        };
        "image/svg+xml" = {
          action = 3;
          extensions = [ "svg" ];
        };
        "text/xml" = {
          action = 3;
          extensions = [
            "xml"
            "xsl"
          ];
        };
      };

      schemes = {
        mailto = {
          action = 2;
          handlers = [
            {
              name = "Gmail";
              uriTemplate = "https://mail.google.com/mail/?extsrc=mailto&url=%s";
            }
          ];
        };
      };
    };
  };
}
