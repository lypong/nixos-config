{
  description = "Seb NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nur.url = github:nix-community/NUR;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper.url = "github:hyprwm/Hyprpaper";
  };

  outputs = {
    self,
    nixpkgs,
    nur,
    home-manager,
    hyprland,
    hyprpaper,
    ...
  }: let
    system = "x86_64-linux";
    pkg-overlay = final: prev: {
      hyprpaper = hyprpaper.packages.${prev.system}.hyprpaper;
    };
    pkgs = import nixpkgs {
      inherit system;
      overlays = [pkg-overlay];
    };
    lib = nixpkgs.lib;
  in {
    #packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    homeConfigurations.seb = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./users/seb/home.nix
        #./users/seb/hyprland.nix
        hyprland.homeManagerModules.default
        nur.nixosModules.nur
      ];
    };

    nixosConfigurations = {
      abricot = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/common/configuration.nix
          ./hosts/abricot/hostname.nix
          ./hosts/abricot/hardware-configuration.nix
        ];
      };
      liloco = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/common/configuration.nix
          ./hosts/liloco/hostname.nix
          ./hosts/liloco/hardware-configuration.nix
          ./hosts/liloco/networkmanager.nix
        ];
      };
    };
  };
}
