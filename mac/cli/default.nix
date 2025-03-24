{ pkgs, ... }:

{
    imports = [
        # ./nvim.nix
        ./fish.nix
        ./nushell.nix
    ];
}