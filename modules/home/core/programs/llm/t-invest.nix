{ root, ... }:
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
        sopsFile = root + "/secrets/users/${user.name}.yaml";
      };

      programs.mcp.servers.t-invest = {
        command = lib.getExe pkgs.mcp-proxy;
        args = [
          "--transport=streamablehttp"
          "--verify-ssl=${root + /certs/russian_trusted_root_ca.pem}"
          "https://invest-public-api.tbank.ru/mcp"
        ];
        env.API_ACCESS_TOKEN.file = config.sops.secrets."t-invest/token-readonly".path;
      };
    };
}
