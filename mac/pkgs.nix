{ pkgs, neovimd,... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ 
    pkgs.vim 
    pkgs.neofetch 
    pkgs.git 
    pkgs.iterm2
    pkgs.nushell
  ];

  environment.etc.shells.text = ''
    /etc/profiles/per-user/iris/bin/nu
  '';


  # nix.package = pkgs.nix;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  # Create /etc/zshrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
