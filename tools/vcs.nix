{ ... }: {
  programs.git = {
    enable = true;
    settings.user.name = "city-high-rider";
    settings.user.email = "60808209+city-high-rider@users.noreply.github.com";
    settings.credential = {
      "https://codeberg.org/" = { helper = "store"; };
      "https://github.com/" = { helper = "!gh auth git-credential"; };
      "https://gist.github.com/" = { helper = "!gh auth git-credential"; };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
  };

}
