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
            export PATH="$HOME/.pyenv/shims:$PATH"
            export PATH="$HOME/.cargo/bin:$PATH"

            zoxide init fish --cmd x | source
            atuin init fish | source

            
        '';

        plugins = [];
    };

    programs.starship = {
        enable = true;
        settings = {
            add_newline = false;
            aws.disabled = true;
            gcloud.disabled = true;
            # line_break.disabled = true;

            time.disabled = false;

            format = "$username@$hostname$directory\n$character";
            right_format = "$all$time";

            character.success_symbol = "[✡︎](green)[~>](purple)";
            character.error_symbol = "[✡︎](read)[~>](purple)";
        };
    };

    programs.pyenv = {
        enable = true;
    };

    programs.atuin = {
        enable = true;
        enableFishIntegration = true;
        settings = {
            auto_sync = true;
            sync_frequency = "5m";
            sync_address = "https://api.atuin.sh";
            search_mode = "prefix";
        };
    };
}