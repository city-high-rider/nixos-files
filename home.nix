{ ... }: {

  # The configs for different software/usecases live in their own files. Import them all here.
  imports = [
    ./desktop/cursor.nix
    ./desktop/fonts.nix
    ./desktop/fuzzel.nix
    ./desktop/idledaemon.nix
    ./desktop/lockscreen.nix
    ./desktop/niri.nix
    ./desktop/notifications.nix
    ./desktop/waybar.nix

    ./tools/music-player.nix
    ./tools/helix.nix
    ./tools/obs.nix
    ./tools/terminal.nix
    ./tools/vcs.nix
  ];

  home = {
    username = "nick";
    homeDirectory = "/home/nick";
    stateVersion = "24.05";
  };

  xdg.userDirs.enable = true;
}
