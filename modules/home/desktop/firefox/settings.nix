{
  flake.modules.homeManager.firefox = {
    programs.firefox.profiles.default.settings = {
      "browser.contentblocking.category" = "strict";

      "privacy.globalprivacycontrol.enabled" = true;

      "dom.security.https_only_mode" = true;

      "browser.ml.chat.enabled" = false;
      "browser.ml.chat.page" = false;
      "browser.ml.linkPreview.enabled" = false;
      "extensions.ml.enabled" = false;
      "browser.tabs.groups.smart.enabled" = false;
      "browser.tabs.groups.smart.userEnabled" = false;
      "browser.ai.control.default" = "blocked";
      "browser.ai.control.linkPreviewKeyPoints" = "blocked";
      "browser.ai.control.pdfjsAltText" = "blocked";
      "browser.ai.control.sidebarChatbot" = "blocked";
      "browser.ai.control.smartTabGroups" = "blocked";
      "browser.ai.control.smartWindow" = "blocked";

      "browser.ai.control.translations" = "available";
      "browser.translations.enable" = true;
      "browser.translations.select.enable" = true;
      "browser.translations.automaticallyPopup" = false;
      "browser.translations.mostRecentTargetLanguages" = "ru";

      "browser.startup.homepage" = "about:blank";
      "browser.newtabpage.enabled" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;

      "general.autoScroll" = true;
      "findbar.highlightAll" = true;
      "accessibility.typeaheadfind.flashBar" = 0;

      "media.eme.enabled" = true;

      "intl.accept_languages" = "en-us,en,ru";
      "intl.regional_prefs.use_os_locales" = true;

      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
}
