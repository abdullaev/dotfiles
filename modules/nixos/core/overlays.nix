{
  config,
  inputs,
  lib,
  root,
  ...
}:
{
  flake.overlays.default = lib.composeManyExtensions [
    # herdr drops the underline color when it serializes a pane frame for the
    # client, so neovim's diagnostic undercurls come out in the foreground
    # color instead of the severity color. Carry the fix until it lands
    # upstream (0.8.2 preserves the color in the pane render path, but the
    # wire-format CellData and client SGR emission still drop it).
    (_: prev: {
      herdr = prev.herdr.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ (root + /pkgs/herdr/underline-color.patch) ];
      });
    })

    (final: _: {
      pragmata-pro = inputs.pragmata-pro.packages.${final.stdenv.hostPlatform.system}.default;
    })

    (final: _: {
      inherit (inputs.llm-agents.packages.${final.stdenv.hostPlatform.system})
        claude-code
        opencode
        ;
    })

    (final: _: {
      firefox-addons = inputs.firefox-addons.packages.${final.stdenv.hostPlatform.system};
    })
  ];

  flake.modules.nixos.overlays = {
    nixpkgs.overlays = [ config.flake.overlays.default ];
  };
}
