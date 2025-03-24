

# add some path
# 基础 Nushell 配置文件

# 环境变量设置
$env.EDITOR = "hx"
$env.VISUAL = "hx"

# 自定义命令和别名
def ll [] { ls -la | sort-by modified -r }

$env.PATH = ($env.PATH | 
  split row (char esep) | 
  prepend [
    # 本地二进制文件路径
    $"($env.HOME)/.local/bin"
    $"/etc/profiles/per-user/($env.USER)/bin"
    # Homebrew 路径
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    # Nix 相关路径
    "/nix/var/nix/profiles/default/bin"
    $"($env.HOME)/.nix-profile/bin"
    # 其他常用工具路径
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
    $"($env.HOME)/.cargo/bin"
    # old nix darwin bin location
    /run/current-system/sw/bin
  ] | 
  uniq
)

# 模块导入
use std

# 终端集成
$env.config = {
    edit_mode: emacs
    show_banner: false
}

# 如果您有其他自定义配置，可以在这里添加
# go private
$env.GOPRIVATE = "git.garena.com"

# some plugins
source ~/.config/zoxide.nu
