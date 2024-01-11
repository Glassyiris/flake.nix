{
    programs.fish = {
        enable = true;
        shellAliases = {
            ls = "lsd";
            ll = "lsd -al";
            lsh = "lsd -alh";
            "darwin-rebuild" = "nix run nix-darwin --";
        };
        
        interactiveShellInit = ''
            export PATH="/run/current-system/sw/bin:$PATH"
            export PATH="/etc/profiles/per-user/$USER/bin:$PATH"
        '';
    };
}