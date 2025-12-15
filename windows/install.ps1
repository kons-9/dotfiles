# Windows PowerShell 用 dotfiles インストールスクリプト
$HOME = $env:USERPROFILE

# dotfiles ルートパス（スクリプトの場所）
$DOTFILES = Split-Path -Parent $MyInvocation.MyCommand.Path

# common = $DOTFILES/nix/home/
$COMMON = Join-Path $DOTFILES "nix/home"
# windows = $DOTFILES/windows/
$WINDOWS = Join-Path $DOTFILES "windows"

# シンボリックリンク作成関数
function New-Link($Source, $Target) {
    if (Test-Path $Target) {
        Write-Host "Skipped: $Target already exists"
    } else {
        Write-Host "Linking: $Source -> $Target"
        New-Item -ItemType SymbolicLink -Path $Target -Target $Source
    }
}

# ----------------------------
# common 配下を展開
# ----------------------------
# nvim
$COMMON_NVIM = Join-Path $COMMON "editor/nvim"
$TARGET_NVIM = Join-Path $HOME "AppData\Local\nvim"
New-Link $COMMON_NVIM $TARGET_NVIM

# vscode
$COMMON_VSCODE = Join-Path $COMMON "editor/vscode"
$TARGET_VSCODE = Join-Path $HOME "AppData\Roaming\Code\User"
New-Link $COMMON_VSCODE $TARGET_VSCODE

# gitconfig
$COMMON_GIT = Join-Path $COMMON "git/config"
$TARGET_GIT = Join-Path $HOME ".gitconfig"
New-Link $COMMON_GIT $TARGET_GIT

# gitignore
$COMMON_GITIGNORE = Join-Path $COMMON "git/gitignore"
$TARGET_GITIGNORE = Join-Path $HOME ".gitignore"
New-Link $COMMON_GITIGNORE $TARGET_GITIGNORE

# terminal (wezterm)
$COMMON_WEZTERM = Join-Path $COMMON "terminal/wezterm"
$TARGET_WEZTERM = Join-Path $HOME "AppData\Local\wezterm"
New-Link $COMMON_WEZTERM $TARGET_WEZTERM

# alacrity 
$COMMON_WEZTERM_CONFIG = Join-Path $COMMON "terminal/alacritty"
$TARGET_WEZTERM_CONFIG = Join-Path $HOME "AppData\Roaming\alacritty"
New-Link $COMMON_ALACRITTY $TARGET_ALACRITTY

# tmux
$COMMON_TMUX = Join-Path $COMMON "tmux/tmux.conf"
$TARGET_TMUX = Join-Path $HOME ".tmux.conf"
New-Link $COMMON_TMUX $TARGET_TMUX

# python startup script
$COMMON_PYTHON = Join-Path $COMMON "lang/python/startup.py"
$TARGET_PYTHON = Join-Path $HOME "startup.py"
New-Link $COMMON_PYTHON $TARGET_PYTHON

# clang-format
$COMMON_CLANG = Join-Path $COMMON "lang/clang/.clang-format"
$TARGET_CLANG = Join-Path $HOME ".clang-format"
New-Link $COMMON_CLANG $TARGET_CLANG

# ----------------------------
# windows 専用
# ----------------------------
$WINDOWS_WEZ_AHK = Join-Path $WINDOWS "AutoHotkey/wezterm.ahk"
$TARGET_WEZ_AHK = Join-Path $HOME "wezterm.ahk"
New-Link $WINDOWS_WEZ_AHK $TARGET_WEZ_AHK

Write-Host "`nDotfiles installation completed!"

