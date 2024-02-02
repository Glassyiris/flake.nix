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

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#irisdeMac-Pro
    darwinConfigurations."irisdeMac-Pro" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.darwinModules.home-manager
          ./mac
        ]; 
    };

    nixosConfigurations = {
      "laby" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # 这里导入之前我们使用的 configuration.nix，这样旧的配置文件仍然能生效
          # 注: configuration.nix 本身也是一个 Nixpkgs Module，因此可以直接在这里导入
          ./configuration.nix
        ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."irisdeMac-Pro".pkgs;
  };
}
