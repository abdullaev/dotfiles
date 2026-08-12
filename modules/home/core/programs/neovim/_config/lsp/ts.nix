{
  pkgs,
  lib,
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;

  # `@typescript/*` platform packages are named after node's platform and arch.
  nodePlatform =
    {
      x86_64-linux = "linux-x64";
      aarch64-linux = "linux-arm64";
      x86_64-darwin = "darwin-x64";
      aarch64-darwin = "darwin-arm64";
    }
    .${system};

  tsgoCmd =
    lib.replaceStrings
      [ "@platform@" "@fallback@" ]
      [
        nodePlatform
        (lib.getExe' pkgs.typescript-go "tsgo")
      ]
      (builtins.readFile ../lua/tsgo-cmd.lua);
in
{
  lsp.servers.typescript-go.cmd = lib.mkForce (
    lib.generators.mkLuaInline "(function()\n${tsgoCmd}\nend)()"
  );
}
