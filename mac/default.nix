{ pkgs, ... }:

{
    imports = [
        ./pkgs.nix
        ./home.nix
    ];
}