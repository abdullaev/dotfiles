{ pkgs, ... }:
{
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "nuphy-air75-v3-udev";
      destination = "/lib/udev/rules.d/70-nuphy-air75-v3.rules";
      text = ''
        SUBSYSTEM=="hidraw", ENV{ID_USB_VENDOR_ID}=="19f5", ENV{ID_USB_MODEL_ID}=="1028", ENV{ID_USB_INTERFACE_NUM}=="03", TAG+="uaccess"
      '';
    })
  ];
}
