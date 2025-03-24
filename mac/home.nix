{ config, pkgs, home-manager, lib, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.iris = {
    # 注意修改这里的用户名与用户目录
    home.username = "iris";
    home.homeDirectory = lib.mkForce "/Users/iris";

    # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
    # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

    # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
    # home.file.".config/i3/scripts" = {
    #   source = ./scripts;
    #   recursive = true;   # 递归整个文件夹
    #   executable = true;  # 将其中所有文件添加「执行」权限
    # };

    # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
    # home.file.".xxx".text = ''
    #     xxx
    # '';

    # git 相关配置
    programs.git = {
      enable = true;
      userName = "eries";
      userEmail = "coloredflowers@outlook.com";
    };

    # 通过 home.packages 安装一些常用的软件
    home.packages = with pkgs; [
      # 如下是我常用的一些命令行工具，你可以根据自己的需要进行增删
      neofetch
      # utils
      ripgrep # recursively searches directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
      yq-go # yaml processer https://github.com/mikefarah/yq
      fzf # A command-line fuzzy finder

      # networking tools
      mtr # A network diagnostic tool
      iperf3
      aria2 # A lightweight multi-protocol & multi-source command-line download utility

      # misc
      cowsay
      file
      lsd
      bat
      fira-code-nerdfont
      nix-prefetch-github
      nix-prefetch-git
      rustup

      zoxide
      openssl
      nushell
    ];

    imports = [ ./cli ];

    home.stateVersion = "24.05";
    fonts.fontconfig.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
