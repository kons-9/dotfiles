# 開発スタイル

- シンプルで明確なコードを書く。巧妙さよりも可読性を優先する
- 既存プロジェクトの規約・スタイルに従う
- 不明瞭な指示は質問して明確にする

# コード設計

- 関心の分離を保つ
- 状態とロジックを分離する
- 可読性と保守性を重視する
- コントラクト層（API/型）を厳密に定義する

# 言語

- Rust: イディオマティックに書く。本番コードで `unwrap` 禁止、`?` 演算子を使う
- Python: 型ヒント必須、f-string を使う
- TypeScript: strict mode
- 公開リポジトリではドキュメントやコミットメッセージを英語で記述する

# ツール

- エディタ: Neovim
- シェル: zsh (sheldon), PowerShell (Windows)
- ターミナル: WezTerm
- dotfiles 管理: chezmoi
- パッケージ管理: Nix (Home Manager), uv (Python), Volta (Node.js), cargo (Rust)
- CLI: eza, bat, fd, ripgrep, zoxide

# 環境

- GitHub: kons-9
- マルチプラットフォーム: Linux (Arch/Ubuntu) + Windows
- XDG Base Directory 準拠

# Git

- Conventional Commits (feat:, fix:, refactor:, docs:, chore:)
- アトミックコミット
- プルストラテジー: fast-forward only
- デフォルトブランチ: main

# 破壊的操作

- ツール（chezmoi / home-manager / brew / npm 等）が auto-rename した `*.backup` / `*.orig` 系ファイルを `rm` する前に、内容を `cat` して確認する。最低 1 回の表示を経てから削除する
- `git push --force`、`rm -rf`、ブランチ削除などの不可逆操作は実行前に確認する

# スキル管理

新規 skill を作るとき、配置先を次の指針で決める:

- **プロジェクト固有** (`<repo>/.claude/skills/` に配置): 特定リポジトリのドメイン知識・規約に依存し、他リポジトリで使う見込みがない
- **グローバル** (`~/.claude/skills/` に配置、chezmoi 管理): 言語・ツール横断で複数リポジトリで再利用可能
- **判断不能なとき**: ユーザーに「プロジェクト固有かグローバルか」を質問してから作成

# 振り返り

- タスク完了時に試行錯誤があった場合、`retrospective-codify` skill のワークフローに従い知見を抽出する
- 静的検査可能なルールはプロンプトではなく linter で記述する
- CLAUDE.md / skill の変更は必ず提案 → 承認 → 書き出しの順序を守る
