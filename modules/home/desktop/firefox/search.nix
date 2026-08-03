{
  flake.modules.homeManager.firefox = {
    programs.firefox.profiles.default.search = {
      default = "google";
      privateDefault = "google";

      order = [
        "google"
        "ddg"
      ];

      engines = {
        bing.metaData.hidden = true;
        perplexity.metaData.hidden = true;
        wikipedia.metaData.hidden = true;
      };
    };
  };
}
