#!/usr/bin/env bash
# iTerm2 全局偏好设置（这些不在动态配置里，需用 defaults 写入）
# ⚠️ 运行前请完全退出 iTerm2（⌘Q），否则退出时会覆盖这些设置。
set -euo pipefail

echo "写入 iTerm2 全局偏好…"

# 选中即复制
defaults write com.googlecode.iterm2 CopySelection -bool true

# 默认使用 Anthropic 配置（GUID 与 Anthropic.json 中一致）
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "anthropic-claude-theme-001"

echo "完成。重新打开 iTerm2 即可生效。"
