#!/bin/bash
# chezmoi デプロイの検証スクリプト
set -e

PASS=0
FAIL=0
WARN=0

check() {
    local desc="$1"
    local path="$2"
    if [ -e "$path" ]; then
        echo "  [PASS] $desc: $path"
        ((PASS++))
    else
        echo "  [FAIL] $desc: $path"
        ((FAIL++))
    fi
}

check_content() {
    local desc="$1"
    local path="$2"
    local expected="$3"
    if [ -f "$path" ] && grep -q "$expected" "$path"; then
        echo "  [PASS] $desc"
        ((PASS++))
    else
        echo "  [FAIL] $desc (expected '$expected' in $path)"
        ((FAIL++))
    fi
}

echo "=============================="
echo "  chezmoi deploy verification"
echo "=============================="
echo ""

HOME_DIR="/home/testuser"
XDG_CONFIG="$HOME_DIR/.xdg/config"

# --- XDG bootstrap ---
echo "[1] XDG Bootstrap"
check ".zshenv exists" "$HOME_DIR/.zshenv"
check_content ".zshenv sets XDG_CONFIG_HOME" "$HOME_DIR/.zshenv" "XDG_CONFIG_HOME"

# --- Neovim ---
echo ""
echo "[2] Neovim"
check "nvim/init.lua" "$XDG_CONFIG/nvim/init.lua"
check "nvim/lua/" "$XDG_CONFIG/nvim/lua"
check "nvim/lua/keymapping.lua" "$XDG_CONFIG/nvim/lua/keymapping.lua"
check "nvim/lua/lazydir/init.lua" "$XDG_CONFIG/nvim/lua/lazydir/init.lua"

# --- VSCode ---
echo ""
echo "[3] VSCode"
check "Code/User/keybindings.json" "$XDG_CONFIG/Code/User/keybindings.json"
check "Code/User/settings.json" "$XDG_CONFIG/Code/User/settings.json"

# --- Git ---
echo ""
echo "[4] Git"
check "git/config" "$XDG_CONFIG/git/config"
check "git/ignore" "$XDG_CONFIG/git/ignore"
check_content "git config has user.name" "$XDG_CONFIG/git/config" "name = toshiki goto"

# --- Zsh ---
echo ""
echo "[5] Zsh"
check "zsh/env.zsh" "$XDG_CONFIG/zsh/env.zsh"
check "zsh/alias.zsh" "$XDG_CONFIG/zsh/alias.zsh"
check "zsh/utils.zsh" "$XDG_CONFIG/zsh/utils.zsh"
check "zsh/prompt.zsh" "$XDG_CONFIG/zsh/prompt.zsh"
check "zsh/misc.zsh" "$XDG_CONFIG/zsh/misc.zsh"
check "zsh/.zshrc" "$XDG_CONFIG/zsh/.zshrc"
check "zsh/sheldon/plugins.toml" "$XDG_CONFIG/zsh/sheldon/plugins.toml"
check "zsh/external_command/zoxide.zsh" "$XDG_CONFIG/zsh/external_command/zoxide.zsh"

# --- WezTerm ---
echo ""
echo "[6] WezTerm"
check "wezterm/wezterm.lua" "$XDG_CONFIG/wezterm/wezterm.lua"

# --- tmux ---
echo ""
echo "[7] tmux"
check "tmux/tmux.conf" "$XDG_CONFIG/tmux/tmux.conf"
check "tmux/scripts/tmux-session-popup.sh" "$XDG_CONFIG/tmux/scripts/tmux-session-popup.sh"

# --- Alacritty ---
echo ""
echo "[8] Alacritty"
check "alacritty/alacritty.toml" "$XDG_CONFIG/alacritty/alacritty.toml"

# --- xremap ---
echo ""
echo "[9] xremap"
check "xremap/config.yml" "$XDG_CONFIG/xremap/config.yml"
check "xremap/systemd/xremap.service" "$XDG_CONFIG/xremap/systemd/xremap.service"
# systemd service にハードコードパスが無いこと
if [ -f "$XDG_CONFIG/xremap/systemd/xremap.service" ]; then
    if grep -q "toshiki" "$XDG_CONFIG/xremap/systemd/xremap.service"; then
        echo "  [FAIL] xremap.service still contains hardcoded 'toshiki'"
        ((FAIL++))
    else
        echo "  [PASS] xremap.service has no hardcoded username"
        ((PASS++))
    fi
fi

# --- Python ---
echo ""
echo "[10] Python"
check "python/startup.py" "$XDG_CONFIG/python/startup.py"

# --- clang ---
echo ""
echo "[11] clang"
check "clang/.clang-format" "$XDG_CONFIG/clang/.clang-format"

# --- Claude ---
echo ""
echo "[12] Claude"
check ".claude/CLAUDE.md" "$HOME_DIR/.claude/CLAUDE.md"

# --- Summary ---
echo ""
echo "=============================="
echo "  Results: $PASS passed, $FAIL failed"
echo "=============================="

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
