{ config, pkgs, ... }:

{

  home.username = "seb";
  home.homeDirectory = "/home/seb";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
  wayland.windowManager.hyprland = import ./hyprland.nix;
}

