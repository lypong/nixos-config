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
  };

  outputs = {
    self,
    nixpkgs,
    nur,
    home-manager,
    hyprland,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
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
        modules = [./configuration.nix];
      };
    };
  };
}
