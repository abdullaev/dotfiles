{ lib }:
{
  autocomplete = {
    blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts = {
        sources.providers.snippets.opts.filter_snippets = lib.generators.mkLuaInline ''
          function(filetype, file)
            return not (
              filetype ~= "all"
              and file:match("friendly%-snippets/snippets/global%.json$")
            )
          end
        '';
        keymap = {
          preset = "default";
        };
        cmdline = {
          keymap = {
            "<C-y>" = [
              "select_and_accept"
              "fallback"
            ];
          };
        };
        completion = {
          menu = {
            auto_show = true;
            scrollbar = false;
          };
          documentation = {
            auto_show = true;
            window = {
              scrollbar = false;
            };
          };
        };
        signature = {
          enabled = true;
          window = {
            scrollbar = false;
          };
        };
      };
    };
  };
}
