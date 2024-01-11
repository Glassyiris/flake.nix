{
    programs.fish = {
        enable = true;
        shellAliases = {
            ls = "lsd";
            ll = "lsd -al";
            lsh = "lsd -alh";
        };
        interactiveShellInit = ''
            export PATH="/etc/profiles/per-user/$USER/bin:$PATH"
        '';
    };
}