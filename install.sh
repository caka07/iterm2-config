#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
# dotfiles 一键安装脚本（macOS）
# 用法：  cd ~/dotfiles && ./install.sh
# 作用：  装齐所有包/字体，并将配置软链接到正确位置（原文件会备份）
# ─────────────────────────────────────────────────────────────
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

info() { printf "\033[1;38;2;217;119;87m▶\033[0m %s\n" "$1"; }

# 1) Homebrew
if ! command -v brew >/dev/null 2>&1; then
  info "安装 Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || true)"

# 2) 包 + 字体
info "通过 Brewfile 安装包与字体…"
brew bundle --file="$DOTFILES/Brewfile"

# 3) 软链接配置（备份已有文件）
link() {  # link <源(相对dotfiles)> <目标绝对路径>
  local src="$DOTFILES/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP/$(dirname "${dst#$HOME/}")"
    mv "$dst" "$BACKUP/${dst#$HOME/}"
    info "备份原文件 -> $BACKUP/${dst#$HOME/}"
  fi
  ln -s "$src" "$dst"
  info "链接 $1 -> $dst"
}

link shell/zshrc            "$HOME/.zshrc"
link starship/starship.toml "$HOME/.config/starship.toml"
link atuin/config.toml      "$HOME/.config/atuin/config.toml"
link bat/config             "$HOME/.config/bat/config"
link ripgrep/ripgreprc      "$HOME/.config/ripgrep/ripgreprc"

# 4) iTerm2 动态配置（动态配置目录不能软链，直接拷贝）
ITERM_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
mkdir -p "$ITERM_DIR"
cp "$DOTFILES/iterm2/Anthropic.json" "$ITERM_DIR/Anthropic.json"
info "已安装 iTerm2 动态配置 Anthropic"

# 5) iTerm2 shell integration（含 imgcat 等看图工具）
if [ ! -e "$HOME/.iterm2_shell_integration.zsh" ]; then
  info "安装 iTerm2 shell integration…"
  curl -fsSL https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
fi

# 6) iTerm2 全局偏好（请先确保 iTerm2 已退出）
if ! pgrep -x iTerm2 >/dev/null 2>&1; then
  bash "$DOTFILES/iterm2/defaults.sh"
else
  info "⚠️  iTerm2 正在运行，跳过全局偏好。请 ⌘Q 退出后运行： bash iterm2/defaults.sh"
fi

# 7) atuin 导入已有 zsh 历史
command -v atuin >/dev/null 2>&1 && atuin import auto || true

info "全部完成！请重开终端，并把 iTerm2 字体设为 BlexMono Nerd Font / 中文 LXGW WenKai Mono（动态配置已指定，通常自动生效）。"
