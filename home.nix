{ ... }:
{

  # The configs for different software/usecases live in their own files. Import them all here.
  imports = [ ];

  home = {
    username = "nick";
    homeDirectory = "/home/nick";
    stateVersion = "24.05";
  };

  xdg.userDirs.enable = true;
}
