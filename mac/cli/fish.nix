{pkgs, ...}:

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

            zoxide init fish --cmd x | source
        '';

        plugins = [];
    };

    programs.starship = {
        enable = true;
        settings = {
            add_newline = false;
            aws.disabled = true;
            gcloud.disabled = true;
            line_break.disabled = true;

            format = "$character";
            right_format = "$all";
        };
    };

}