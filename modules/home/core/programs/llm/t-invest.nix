{
  flake.modules.homeManager.llm =
    {
      config,
      lib,
      pkgs,
      user,
      ...
    }:
    {
      sops.secrets."t-invest/token-readonly" = {
        sopsFile = ../../../../../secrets/users + "/${user.name}.yaml";
      };

      programs.mcp.servers.t-invest = {
        command = lib.getExe pkgs.mcp-proxy;
        args = [
          "--transport=streamablehttp"
          "--verify-ssl=${../../../../../certs/russian_trusted_root_ca.cer}"
          "https://invest-public-api.tbank.ru/mcp"
        ];
        env.API_ACCESS_TOKEN.file = config.sops.secrets."t-invest/token-readonly".path;
      };
    };
}
