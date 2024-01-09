{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#irisdeMac-Pro
    darwinConfigurations."irisdeMac-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
        ./mac/pkgs.nix
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."irisdeMac-Pro".pkgs;
  };
}