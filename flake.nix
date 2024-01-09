{
  description = "Example Darwin system flake";

  inputs = {
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvimdots.url = "github:ayamir/nvimdots";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, ... }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#irisdeMac-Pro
    darwinConfigurations."irisdeMac-Pro" =
      nix-darwin.lib.darwinSystem { 
        modules = [ 
          ./mac 
        ]; 
      };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."irisdeMac-Pro".pkgs;
  };
}
