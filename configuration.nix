# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kropotkin";
  networking.nameservers = [ "9.9.9.9" "149.112.112.112" "1.1.1.1" "1.0.0.1" ];
  networking.wireless.enable = true;

  networking.wireless.networks."MaximumWarp-5G".psk = "Picard@123";

  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  fonts.fonts = with pkgs; [ hack-font ];

  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "nivida" ];

    windowManager.i3.enable = true;
    displayManager.startx.enable = true;
  };

  services.printing.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver.libinput.enable = true;

  users.users.atalii = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "docker" "bluetooth" ];

    shell = pkgs.mksh;
  };

  environment.systemPackages = with pkgs; [
    xz tailscale
    nvi neovim cmus neofetch kitty mksh xclip

    git pulsemixer

    firefox thunderbird

    discord
  ];

  networking.firewall.enable = false;

  system.stateVersion = "23.05";

}

