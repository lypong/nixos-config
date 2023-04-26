{
  config,
  pkgs,
  ...
}: let
  setupFirefox = import ./firefox.nix;
  setupFish = import ./fish.nix;
  setupAlacritty = import ./alacritty.nix;
in {
  imports = [
    setupFirefox
    setupFish
    setupAlacritty
  ];
  home.username = "seb";
  home.homeDirectory = "/home/seb";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    vscodium-fhs
    firefox
    alacritty
    fish
  ];

  programs.home-manager.enable = true;
}
