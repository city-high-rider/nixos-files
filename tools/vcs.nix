{ ... }: {
  programs.git = {
    enable = true;
    userName = "city-high-rider";
    userEmail = "60808209+city-high-rider@users.noreply.github.com";
    extraConfig.credential = {
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
