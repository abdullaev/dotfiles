{
  flake.modules.nixos.packages =
    { pkgs, inputs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wget
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
