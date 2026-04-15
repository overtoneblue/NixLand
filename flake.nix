{
  description = "NixOS Flake by Cenunix";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland?ref=v0.53.3";

    dankmaterialshell = {
      url = "github:AvengeMedia/DankMaterialShell?ref=v0.6.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";
      flake = false;
    };

    wallpkgs.url = "github:NotAShelf/wallpkgs"; # no need to follow nixpkgs

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.home-manager.flakeModules.home-manager
      ];
      flake = {
        nixosConfigurations = {
          europa = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/europa
            ];
          };

          callisto = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/callisto
            ];
          };
        };
        homeModules.myNeovim = import ./core/programs/nvf { inherit inputs; };
      };
    };
}
