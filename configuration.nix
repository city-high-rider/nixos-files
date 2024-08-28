# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  # Use GRUB as the bootloader.
  boot.loader.grub = {
    enable = true;
    devices = ["nodev"];
    efiInstallAsRemovable = true;
    efiSupport = true;
    useOSProber = true;
  };

  # Support ZFS and request credentials on boot
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.requestEncryptionCredentials = true;

  # No fucking clue what the second one does, but sound doesn't work without it.
  boot.kernelParams = ["boot.shell_on_fail" "snd-intel-dspcfg.dsp_driver=1"];

  # Use ZFS auto scrub
  services.zfs.autoScrub.enable = true;
  # enable TLP for laptop battery
  services.tlp.enable = true;

  # HostID for ZFS
  networking.hostId = "81fab459";

  networking.hostName = "omen15"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # NM applet so I don't have to use the CLI to manage
  # network connections.
  programs.nm-applet.enable = true;

  # Automatic deletion of old builds and nix store optimization.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;

  # Wayland setup.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; 
  };

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
   nvidia.modesetting.enable = true; 
  };

  # Enables drivers for x and wayland, despite the name
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = ["nvidia"];

  # Enable flatpaks.
  # Then you will still have to add
  # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];  
  };

  # Logind handles what happens when laptop lid is closed.
  # https://nixos.wiki/wiki/Logind
  # I want hyprland to detect these events and do stuff, so...
  services.logind = {
    lidSwitch = "ignore";
  };


  # TODO: Unfuck this. For some reason, the command is set to 'md'.
  services.greetd =
    let
      tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
      session = "${pkgs.hyprland}/bin/Hyprland";
      username = "nick";
    in {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };
      default_session = {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
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
  security.pam.services.hyprlock = {};
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nick = {
    isNormalUser = true;
    initialPassword = "cats";
    extraGroups = [ "wheel" "audio" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      #firefox
      #tree
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    helix # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    home-manager
    (waybar.overrideAttrs (oldAttrs : {mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];}))
    # Notification daemon
    mako
    libnotify

    # Wallpaper daemon
    swww

    # Terminal emulator
    kitty

    # Color picker
    hyprpicker

    # rofi on wayland
    rofi-wayland
    rofi-power-menu

    firefox

    # Make sound work lol
    sof-firmware
    pavucontrol

    # For changing screen brightness
    brightnessctl

    # Screenshotting
    grim
    slurp
    swappy

    fortune-kind
    cowsay

    mangohud

    unzip
  ];

  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
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

