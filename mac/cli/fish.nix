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

            # pure set
            set --universal pure_enable_single_line_prompt true
            set --universal pure_show_system_time true
            set --universal pure_color_system_time pure_color_mute
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