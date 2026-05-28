# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  # Use GRUB as the bootloader.
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiInstallAsRemovable = false;
    efiSupport = true;
    useOSProber = true;
  };

  # Support ZFS and request credentials on boot
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.requestEncryptionCredentials = true;

  # No fucking clue what the second one does, but sound doesn't work without it.
  boot.kernelParams = [
    "boot.shell_on_fail"
    "snd-intel-dspcfg.dsp_driver=1"
  ];

  # Use ZFS auto scrub
  services.zfs.autoScrub.enable = true;
  # enable TLP for laptop battery
  services.tlp.enable = true;

  services.logmein-hamachi.enable = true;

  # HostID for ZFS
  networking.hostId = "81fab459";

  networking.hostName = "omen15"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Automatic deletion of old builds and nix store optimization.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;

  # Enable niri.
  # This also enables the necessary system components for niri to function properly, such as desktop portals and polkit.
  programs.niri = {
    enable = true;
  };

  programs.git.enable = true;

  environment.sessionVariables = {
    # If your cursor gets invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics = {
      enable = true;
    };

    # Most wayland compositors need this
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      # Use open-source kernel module?
      open = false;
    };

    # This is for constraining drawing tablet area, so it's not super sensitive.
    opentabletdriver.enable = true;
  };

  # Enables drivers for x and wayland, despite the name
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable flatpaks.
  # Then you will still have to add
  # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  services.flatpak.enable = true;

  # Logind handles what happens when laptop lid is closed.
  # https://nixos.wiki/wiki/Logind
  # I want hyprland to detect these events and do stuff, so...
  services.logind = {
    lidSwitch = "ignore";
  };

  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "backspace";
          rightalt = "layer(nav)";
        };

        nav = {
          capslock = "C-backspace";
          space = "enter";
          e = "up";
          s = "left";
          d = "down";
          f = "right";
          w = "home";
          r = "end";
        };
      };
    };
  };
  # Enable bluetooth support
  hardware.bluetooth = {
    enable = true;
    # I want to explicitly have to turn bluetooth on, since I don't
    # use it often, and leaving it on wastes battery.
    powerOnBoot = false;
  };
  # For having bluetooth GUI
  services.blueman.enable = true;

  services.xserver.xkb = {
    layout = "us,us";
    variant = "dvp,"; # dvp is Programmer Dvorak, followed by a default QWERTY
    options = "grp:alt_shift_toggle"; # Press Alt+Shift to toggle between layouts
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Magically make stuff faster by requesting optimizations
  programs.gamemode.enable = true;

  # For hyprlock to work https://mynixos.com/home-manager/option/programs.hyprlock.enable
  security.pam.services.hyprlock = { };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nick = {
    isNormalUser = true;
    initialPassword = "cats";
    extraGroups = [
      "wheel"
      "audio"
      "libvirtd"
      "docker"
    ];
  };

  virtualisation.docker.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    # Helix and nix language server.
    helix
    nil

    wget
    # Notification daemon
    mako
    libnotify
    # for setting XDG dirs.
    xdg-user-dirs

    # Wallpaper daemon
    swww

    # for running X apps on Niri
    xwayland-satellite

    # Terminal emulator
    kitty

    # Color picker
    hyprpicker

    firefox

    # Make sound work lol
    sof-firmware
    pavucontrol

    # For changing screen brightness
    brightnessctl

    # NM applet so I don't have to use the CLI to manage
    # network connections.
    networkmanagerapplet

    # Simple photo editors
    pinta
    swappy

    # Media player
    mpv

    fortune-kind
    cowsay

    # Games
    mangohud
    prismlauncher
    gamescope
    r2modman
    haguichi

    unzip

    warp

    # Mouse tweaks for g502
    piper

    # CLI interface to the clipboard. Used for editing copied things
    # in Niri.
    wl-clipboard

    obsidian
    simplex-chat-desktop
    stoat-desktop
    vesktop

    # File manager ;)
    tree

    # For the MC server
    cloudflared

    # keyboard mouse control
    wl-kbptr
  ];

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.ratbagd.enable = true;

  # For automounting USBS
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    42420
    7777
    5678
    25565
  ];
  networking.firewall.allowedUDPPorts = [
    42420
    7777
    5678
    25565
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
