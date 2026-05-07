---
name: chezmoi-management
description: "chezmoi dotfiles operations: source location, diff/apply flow, template editing, skill addition. Consult when touching ~/.claude/, ~/.config/, or dotfiles."
---

# chezmoi Management

dotfiles 管理の操作ノート。chezmoi 公式ドキュメントで十分な部分は省略し、自分の環境固有のワークフローに絞る。

## 環境

| 項目 | 値 |
|---|---|
| Source directory | `~/.local/share/chezmoi/` (Linux) / chezmoi 管理下 (Windows) |
| Remote | `https://github.com/kons-9/dotfiles.git` |
| Branch | `unstable` |
| マルチプラットフォーム | Linux (Arch/Ubuntu) + Windows |

## レイアウト

```
chezmoi/
├── dot_claude/       → ~/.claude/
│   ├── CLAUDE.md
│   ├── settings.json
│   ├── commands/     (スラッシュコマンド)
│   └── skills/       (スキル)
├── dot_xdg/          → ~/.xdg/ (XDG Base Directory)
│   └── config/
│       ├── git/
│       ├── nvim/
│       ├── zsh/
│       ├── tmux/
│       ├── wezterm/
│       └── ...
├── Documents/PowerShell/  (Windows)
└── run_onchange_windows_symlinks.ps1.tmpl
```

## ファイル名プレフィックス

| prefix | 意味 | 例 |
|---|---|---|
| `dot_` | 先頭に `.` | `dot_zshrc` → `.zshrc` |
| `executable_` | `+x` 権限 | `executable_setup.sh` → `setup.sh` (755) |
| `private_` | `0600` 権限 | `private_key` → `key` |
| `.tmpl` | Go テンプレート | `config.tmpl` → `config` |
| `run_once_` | 初回のみ実行 | `run_once_install.sh` |
| `run_onchange_` | 変更時に実行 | `run_onchange_windows_symlinks.ps1.tmpl` |

## 日常フロー

### (1) 差分確認

```bash
chezmoi diff                   # source と dest の diff
chezmoi status                 # 概要 (MM/M/?? 等)
```

`chezmoi diff` の方向: `- dest` / `+ target` 順（git diff の old=現在 / new=適用後）。

### (2) dest の変更を source に取り込む

```bash
chezmoi add ~/.zshrc                    # 新規ファイルを追加
chezmoi re-add                          # 管理済みファイルの変更を一括反映
chezmoi re-add ~/.claude/CLAUDE.md      # 個別
```

### (3) source の変更を dest に適用

```bash
chezmoi diff                            # まず確認
chezmoi apply                           # 全体
chezmoi apply ~/.claude/CLAUDE.md       # 個別
chezmoi apply --verbose                 # 詳細表示
```

### (4) source をエディタで開く

```bash
chezmoi edit ~/.zshrc                   # source 側を開く
chezmoi edit -a ~/.zshrc                # 編集後に apply も実行
chezmoi cd                              # source dir に cd
```

## テンプレートファイルの編集

`.tmpl` ファイルは Go テンプレート:

```bash
chezmoi edit ~/.claude/CLAUDE.md     # source 側の .tmpl を開く
chezmoi execute-template < foo.tmpl  # 展開結果を確認
chezmoi data                         # テンプレート変数の一覧
```

**注意**: `.tmpl` 管理ファイルに `chezmoi re-add` すると、展開済みの内容で `.tmpl` 構文が上書きされる。`.tmpl` ファイルは `chezmoi edit` か直接編集すること。

```bash
chezmoi source-path ~/.claude/CLAUDE.md
# → .tmpl で終わっていたら re-add 禁止。直接編集する
```

## トラブルシューティング

### source と dest が衝突

```bash
chezmoi merge ~/.zshrc          # 3-way merge
chezmoi forget ~/.something     # source から除外 (dest は残す)
```

### apply で壊した → 前のリビジョンに戻す

chezmoi 自体に undo はない。source 側で git で戻す:
```bash
chezmoi cd
git log --oneline -5
git reset --hard <rev>
cd -
chezmoi apply
```

### 管理対象の確認

```bash
chezmoi managed                 # 管理ファイル一覧
chezmoi managed ~/.claude       # パスでフィルタ
```

## コマンドチートシート

```bash
chezmoi diff                    # diff
chezmoi status                  # status
chezmoi apply [-v]              # apply
chezmoi add <path>              # 新規ファイル取り込み
chezmoi re-add [<path>]         # 既存ファイル再取り込み
chezmoi edit [-a] <path>        # source 編集 (-a で即 apply)
chezmoi merge <path>            # 3-way merge
chezmoi forget <path>           # source から除外
chezmoi managed [<path>]        # 管理ファイル一覧
chezmoi cd                      # source dir へ移動
chezmoi source-path             # source dir パス表示
chezmoi execute-template <      # テンプレート展開テスト
chezmoi data                    # テンプレート変数一覧
chezmoi doctor                  # セットアップ診断
```
