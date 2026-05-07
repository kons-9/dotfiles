# chezmoi - 設定ファイル管理

全プラットフォーム共通の設定ファイル (dotfiles) を管理するディレクトリ。

## 責務

- 設定ファイルの配置とテンプレート展開
- OS・プロファイル別の条件分岐 (work/personal)
- Windows でのシンボリックリンク作成

## セットアップ

### Windows

```powershell
winget install twpayne.chezmoi
chezmoi init --source <path-to-repo>/chezmoi --apply
```

### Linux

```bash
make init-chezmoi
# または
chezmoi init --source <path-to-repo>/chezmoi --apply
```

## 構成

```
chezmoi/
├── .chezmoi.toml.tmpl              # chezmoi 設定 (profile選択)
├── .chezmoiignore                  # OS別除外ルール
├── dot_zshenv                      # ~/.zshenv (XDG bootstrap)
├── dot_claude/                     # Claude Code config
├── dot_xdg/config/
│   ├── nvim/                       # Neovim
│   ├── Code/User/                  # VSCode (settings.json.tmpl)
│   ├── wezterm/                    # WezTerm
│   ├── git/                        # Git (config.tmpl)
│   ├── zsh/                        # Zsh
│   ├── tmux/                       # tmux
│   ├── alacritty/                  # Alacritty (Linux only)
│   ├── xremap/                     # xremap (Linux only)
│   ├── python/                     # Python startup
│   └── clang/                      # .clang-format
├── Documents/PowerShell/           # PS profile (Windows only)
└── run_onchange_windows_symlinks.ps1.tmpl  # Windows symlinks
```

## 仕組み

- 全設定は `~/.xdg/config/` 以下に配置
- `~/.zshenv` が XDG 環境変数と ZDOTDIR を設定
- Windows では `run_onchange` スクリプトがシンボリックリンクを作成
- テンプレート (`.tmpl`) で work/personal の切り替えに対応
- `.chezmoiignore` で OS ごとに不要なファイルを除外

## 追加の設定を移行する場合

```bash
# 例: wezterm を追加
# 1. ファイルをコピー
cp -r nix/home/terminal/wezterm chezmoi/dot_xdg/config/wezterm

# 2. chezmoi apply で確認
chezmoi diff
chezmoi apply
```
