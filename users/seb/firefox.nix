config : {
  enable = true;
  profiles.default = {
    extensions = with config.nur.repos.rycee.firefox-addons; [
      ublock-origin
    ];
  };
}