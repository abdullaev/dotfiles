{
  flake.modules.nixos.overlays = {
    nixpkgs.overlays = [
      # amneziawg kernel module fails to build against kernels without the
      # ipv6 stub; drop once the fix lands in nixpkgs' amneziawg
      # https://github.com/amnezia-vpn/amneziawg-linux-kernel-module/pull/176
      (final: prev: {
        linuxPackages_zen = prev.linuxPackages_zen.extend (
          lpfinal: lpprev: {
            amneziawg = lpprev.amneziawg.overrideAttrs (old: {
              patches = (old.patches or [ ]) ++ [
                (prev.fetchpatch2 {
                  name = "tmp-fix-for-new-kernel-without-ipv6-stub.patch";
                  url = "https://github.com/amnezia-vpn/amneziawg-linux-kernel-module/commit/2a764691e22f15770aa1551ecae12c0431dbd651.patch?full_index=1";
                  stripLen = 1;
                  hash = "sha256-0BcCDBu5XHk1kTrx/24Nwq15n01tCRqnQfBkEvzJmxs=";
                })
              ];
            });
          }
        );
      })
    ];
  };
}
