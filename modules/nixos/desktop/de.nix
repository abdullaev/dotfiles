{
  flake.modules.nixos.de =
    { pkgs, ... }:
    {
      # Electron wrappers in nixpkgs (obsidian, discord, …) only run native
      # Wayland when this is set; without it they fall back to XWayland.
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      programs.ssh.enableAskPassword = true;

      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      environment.systemPackages = with pkgs; [
        wl-clipboard
      ];
    };
}
