# dotfiles

クロスプラットフォーム対応の dotfiles リポジトリ。

## アーキテクチャ

| ツール | 責務 | 対象OS |
|--------|------|--------|
| **chezmoi** | 設定ファイル (dotfiles) の配置・テンプレート展開 | Windows + Linux |
| **Nix (home-manager)** | パッケージインストール・systemdサービス | Linux のみ |

### 設計原則

- **chezmoi** が設定ファイルの Single Source of Truth
- **Nix** はパッケージ管理に専念（`xdg.configFile` 不使用）
- 全設定は `~/.xdg/config/` 以下に配置 (XDG Base Directory 準拠)
- Windows ではシンボリックリンクで各アプリの期待パスに接続

## セットアップ

### Linux (フル)

```bash
# 1. Nix でパッケージをインストール
make init-nix

# 2. chezmoi で設定ファイルを配置
make init-chezmoi

# または一括
make init
```

### Windows

```powershell
winget install twpayne.chezmoi
chezmoi init --source <path-to-repo>/chezmoi --apply
```

## ディレクトリ構成

```
├── chezmoi/          # 設定ファイル (chezmoi source directory)
│   ├── dot_xdg/config/
│   │   ├── nvim/        # Neovim
│   │   ├── Code/User/   # VSCode
│   │   ├── wezterm/     # WezTerm
│   │   ├── git/         # Git
│   │   ├── zsh/         # Zsh
│   │   ├── tmux/        # tmux
│   │   ├── alacritty/   # Alacritty (Linux)
│   │   ├── xremap/      # xremap (Linux)
│   │   ├── python/      # Python startup
│   │   └── clang/       # clang-format
│   ├── dot_zshenv       # ~/.zshenv (bootstrap)
│   ├── dot_claude/      # Claude Code config
│   └── Documents/       # PowerShell profile (Windows)
├── nix/              # パッケージ管理 (Linux)
│   ├── flake.nix
│   └── home/         # home-manager modules (packages only)
├── minimal/          # 最小構成 (参考)
├── initialize/       # 初期化スクリプト (参考)
└── windows/          # Windows 固有ツール (参考)
```

