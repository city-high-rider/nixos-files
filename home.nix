{config,pkgs,...} : {
  home = {
    username = "sillycat";
    homeDirectory = "/home/sillycat";
    stateVersion = "24.05";
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "everforest_light";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
      };
    };
    languages = {
      language-server.texlab.config.texlab.build.onSave = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "city-high-rider";
    userEmail = "60808209+city-high-rider@users.noreply.github.com";
    extraConfig.credential = {
      "https://github.com/" = {
        helper = "!gh auth git-credential";
      };
      "https://gist.github.com/" = {
        helper = "!gh auth git-credential";
      };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      fortune | cowsay
    '';
  };
}

