# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kropotkin";
  networking.nameservers = [ "10.13.12.2" "9.9.9.9" "149.112.112.112" "1.1.1.1" "1.0.0.1" ];
  networking.networkmanager.enable = true;

  networking.wireless.networks."MaximumWarp-5G".psk = "Picard@123";

  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  fonts.fonts = with pkgs; [ hack-font fira-code ];

  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "nvidia" ];

    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    wacom.enable = true;
  };

  programs.xwayland.enable = true;

  services.printing.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;

  virtualisation.docker.enable = true;

  services.postgresql.enable = true;
  services.postgresql.authentication = ''
    host all atalii 0.0.0.0/0 trust
  '';

  programs.dconf.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver.libinput.enable = true;

  users.users.atalii = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "docker" "bluetooth" ];

    shell = pkgs.mksh;
  };

  qt.platformTheme = "gnome";
  qt.style = "adwaita";

  environment.etc."adage.conf".text = ''
    permit g!wheel as root: nopass
  '';

  environment.variables = {
    EDITOR = "vi";
    CC = "distcc gcc";
    CXX = "distcc g++";
    DISTCC_HOSTS = "localhost/7 distcc.atalii.intranet/24";

    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    # apostrophe needs this to show previews.
  };

  environment.shellAliases."b" = "make -j39";

  environment.systemPackages = with pkgs; [
    cachix man-pages distcc gcc gnumake git clang-tools gnat gprbuild
    nvi mksh tree xz tmux
    tailscale
    cmus pulsemixer
    neofetch kitty kate konsole
    xclip kitty
    firefox thunderbird discord audacity
    pandoc texlive.combined.scheme-medium apostrophe
    deja-dup
 
    lutris wineWowPackages.full winetricks
  ];

  networking.firewall.enable = false;

  system.stateVersion = "23.05";

}

