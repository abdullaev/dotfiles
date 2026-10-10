{ root, ... }:
{
  flake.modules.homeManager.firefox =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      firefox = config.programs.firefox;
      profile = firefox.profiles.russian-trusted;
      profileDir = "${firefox.profilesPath}/${profile.path}";
      database = lib.escapeShellArg "sql:${profileDir}";
      certificate = root + /certs/russian_trusted_root_ca.pem;
      certutil = "${pkgs.nssTools}/bin/certutil";
    in
    {
      programs.firefox.profiles.russian-trusted = {
        id = 1;
        isDefault = false;
        settings = {
          "browser.startup.homepage" = "about:blank";
          "dom.security.https_only_mode" = true;
        };
      };

      home.activation.firefoxRussianTrustedCertificate = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
        run mkdir -p -m 700 ${lib.escapeShellArg profileDir}
        if [[ ! -f ${lib.escapeShellArg "${profileDir}/cert9.db"} ]]; then
          run ${certutil} -N --empty-password -d ${database}
        fi
        run ${certutil} -A -d ${database} \
          -n "Russian Trusted Root CA" -t "C,," -a -i ${certificate}
      '';

      xdg.desktopEntries.firefox-russian-trusted = {
        name = "Firefox — Russian Trusted";
        genericName = "Web Browser";
        comment = "Firefox profile with Russian Trusted Root CA";
        exec = "${lib.getExe firefox.finalPackage} -no-remote -P ${profile.name} %u";
        icon = "firefox";
        terminal = false;
        categories = [
          "Network"
          "WebBrowser"
        ];
      };
    };
}
