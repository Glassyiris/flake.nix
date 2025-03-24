{pkgs, lib,config, ...}:

{
    programs = {
        nushell = { 
          enable = true;
          
          # 使用相对路径指向配置文件
          configFile.source = ./config/nushell.nu;
          
          extraConfig = ''
            # 确保基础功能正常工作
            use std
            
            # 自动补全器设置
            let carapace_completer = {|spans|
              carapace $spans.0 nushell ...$spans | from json
            }
            
            $env.config = {
              show_banner: false,
              completions: {
                case_sensitive: false # case-sensitive completions
                quick: true    # set to false to prevent auto-selecting completions
                partial: true    # set to false to prevent partial filling of the prompt
                algorithm: "fuzzy"    # prefix or fuzzy
                external: {
                # set to false to prevent nushell looking into $env.PATH to find more suggestions
                    enable: true 
                # set to lower can improve completion performance at the cost of omitting some options
                    max_results: 100 
                    completer: $carapace_completer # check 'carapace_completer' 
                  }
              }
            } 
            
            # 确保环境路径中包含必要的目录
            $env.PATH = ($env.PATH | 
              split row (char esep) |
              append /usr/bin/env
            )
          '';
          
          shellAliases = {
            vi = "hx";
            vim = "hx";
            nano = "hx";
          };
      };

      carapace.enable = true;
      carapace.enableNushellIntegration = true;
    };
    
    # 确保 home.activation 在需要时创建配置文件
    home.activation.ensureNushellConfig = 
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        ${pkgs.zoxide}/bin/zoxide init nushell --cmd x > ~/.config/zoxide.nu
      '';
}
