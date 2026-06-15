# dotfiles — Anthropic 风格终端环境

一套 macOS 终端配置：iTerm2「Anthropic」浅色主题 + 一组现代化命令行工具，
配色统一为 Anthropic 暖色调（陶土橙 `#D97757` / 暖白底 `#FAF9F5`）。

## 换设备快速还原

```bash
git clone <你的仓库地址> ~/dotfiles   # 或手动拷贝整个 dotfiles 目录
cd ~/dotfiles
./install.sh
```

`install.sh` 会：安装 Homebrew → 用 `Brewfile` 装齐包与字体 →
软链接配置（原文件自动备份到 `~/.dotfiles-backup/`）→ 安装 iTerm2 动态配置、
shell integration、全局偏好 → 导入历史。完成后重开终端即可。

> 安装字体后，若图标显示为 □，到 iTerm2 设置里把字体选为 **BlexMono Nerd Font**
> （动态配置已指定，通常无需手动设置）。

## 目录结构（按类别）

| 路径 | 内容 | 链接目标 |
|------|------|----------|
| `Brewfile` | 所有包 + 字体（`brew bundle`） | — |
| `install.sh` | 一键安装 / 软链接 | — |
| `shell/zshrc` | zsh 主配置（工具初始化、别名、历史、fzf 外观） | `~/.zshrc` |
| `starship/starship.toml` | 提示符主题（Anthropic 双行） | `~/.config/starship.toml` |
| `atuin/config.toml` | 历史管理（紧凑 UI、autumn 主题） | `~/.config/atuin/config.toml` |
| `bat/config` | bat 主题与样式（gruvbox-light） | `~/.config/bat/config` |
| `ripgrep/ripgreprc` | rg 默认参数（智能大小写、排除规则） | `~/.config/ripgrep/ripgreprc` |
| `iterm2/Anthropic.json` | iTerm2 动态配置（字体/颜色/键位/行为） | iTerm2 DynamicProfiles 目录 |
| `iterm2/Anthropic.itermcolors` | 纯颜色主题（可在任意 iTerm2 手动导入） | 手动导入 |
| `iterm2/defaults.sh` | iTerm2 全局偏好（选中即复制、默认配置） | `defaults write` |

## 包含的工具

| 工具 | 作用 |
|------|------|
| starship | 命令行提示符（Git/语言/耗时） |
| eza | `ls` 替代（图标、Git、树状） |
| bat | `cat` 替代（语法高亮） |
| fzf | 模糊搜索（Ctrl-T 文件 / Ctrl-R 历史 / Alt-C 目录） |
| fd | `find` 替代 |
| zoxide | 智能 `cd`（`z 名称` 跳转） |
| ripgrep | `grep` 替代 |
| atuin | shell 历史管理（Ctrl-R 全文搜索） |

## 关键自定义

- **iTerm2**：Anthropic 浅色（暖白底 `#FAF9F5` / 近黑字 `#141413` / 陶土橙光标
  `#D97757`），双字体（英文 BlexMono、中文 LXGW WenKai Mono），无限回滚、
  静音响铃、选中即复制、**Shift+Enter 换行 / Enter 提交**、最小对比度兜底 0.18。
- **fzf**：暖色主题 + bat/eza 预览。
- **zsh 历史**：多终端共享、去重、记录时间戳。

## 手动导入颜色（可选）

如果在某台机器不想用动态配置，可直接在
iTerm2 → Settings → Profiles → Colors → Color Presets → Import…
导入 `iterm2/Anthropic.itermcolors`。
