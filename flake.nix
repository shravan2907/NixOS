{
  description = "A simple NIxOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: rec {
    formatter."x86_64-linux" = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system; config.allowUnfree = true;};
    pkgs-unstable = import nixpkgs-unstable {inherit system; config.allowUnfree = true;};
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit pkgs; inherit pkgs-unstable;};
      modules = [
        ./configuration.nix
      ];
    };

  };
}
