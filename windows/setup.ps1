# Windows 環境セットアップ
# Usage: .\setup.ps1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Continue"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# ─── winget パッケージインストール ────────────────────────────────────────────
$PackagesJson = Join-Path $ScriptDir "packages.json"
Write-Host "Installing packages from $PackagesJson ..."
winget import -i $PackagesJson --accept-package-agreements --accept-source-agreements --ignore-unavailable

# ─── PATH を再読み込み（winget インストール後に反映させる） ──────────────────────
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")

# ─── chezmoi で設定ファイルを展開 ─────────────────────────────────────────────
$ChezmoiSource = Join-Path (Split-Path $ScriptDir) "chezmoi"
Write-Host "`nApplying chezmoi config from $ChezmoiSource ..."

$GitName  = Read-Host "Git user.name"
$GitEmail = Read-Host "Git user.email"
$Profile  = Read-Host "Profile (personal/work)"

chezmoi init --source $ChezmoiSource `
    --promptString "git_name=$GitName" `
    --promptString "git_email=$GitEmail" `
    --promptChoice "profile=$Profile" `
    --apply

Write-Host "`nSetup completed!"
