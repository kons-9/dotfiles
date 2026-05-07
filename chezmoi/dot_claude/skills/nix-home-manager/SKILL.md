---
name: nix-home-manager
description: "Nix flake + Home Manager setup for this dotfiles repo. Use when modifying nix/, adding packages, or troubleshooting nix develop / home-manager switch."
---

# Nix Home Manager Setup

Nix flake ベースの Home Manager 設定。dotfiles リポジトリの `nix/` ディレクトリで管理。

## 構成

```
nix/
├── flake.nix              # エントリポイント
└── home/
    ├── home.nix           # メインモジュール (user: toshiki, XDG 設定)
    ├── cli.nix            # CLI ツール (eza, fd, bat, ripgrep, zoxide, tree)
    ├── editor.nix         # エディタ (Neovim)
    ├── git.nix            # Git 設定
    ├── zsh.nix            # zsh + sheldon
    ├── tmux.nix           # tmux
    ├── terminal.nix       # ターミナル (WezTerm, Alacritty)
    ├── gui.nix            # GUI アプリ
    ├── font.nix           # フォント
    ├── lang.nix           # 言語ツールチェーン
    ├── system.nix         # システム設定 (xremap 等)
    └── editor/nvim/       # Neovim 設定ファイル群
```

## inputs

| input | URL |
|---|---|
| nixpkgs | `github:NixOS/nixpkgs/nixpkgs-unstable` |
| home-manager | `github:nix-community/home-manager` (follows nixpkgs) |

## ターゲット

- `x86_64-linux` のみ
- `allowUnfree = true`
- XDG ディレクトリ: `~/.xdg/{config,data,cache,state}`

## 基本操作

```bash
# 初回セットアップ
nix develop                           # devShell に入る
home-manager switch --flake .#default  # 適用

# 更新
nix flake update                      # 全 input を更新
nix flake update nixpkgs              # nixpkgs のみ更新

# パッケージ追加
# 該当する home/*.nix にパッケージを追加して:
home-manager switch --flake .#default
```

## パッケージ追加の指針

| 用途 | 追加先 |
|---|---|
| CLI ツール | `cli.nix` |
| エディタ関連 | `editor.nix` |
| Git 関連 | `git.nix` |
| 言語ツールチェーン | `lang.nix` |
| フォント | `font.nix` |
| GUI アプリ | `gui.nix` |
| ターミナル | `terminal.nix` |
| シェル | `zsh.nix` |
| システムサービス | `system.nix` |

## トラブルシューティング

### `experimental-features` エラー

```bash
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

### flake input の更新

```bash
nix flake update              # 全 input
nix flake update nixpkgs      # 個別
```

### Home Manager のロールバック

```bash
home-manager generations      # 世代一覧
home-manager switch --flake .#default  # 再適用
```
