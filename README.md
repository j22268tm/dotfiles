# Dotfiles

[chezmoi](https://www.chezmoi.io/)で各種コンフィグファイルを管理する用の個人的なリポジトリです。

Windows (pwsh) と Linux で使えるはず

## 適用できるアプリ一覧
| アプリ名 | config_file |
| ------- | ----------- |
| Alacritty | alacritty/alacritty.toml(.tmpl) |
| Neovim  | nvim(dir) |
| starship | starship.toml(.tmpl) |

## Setup

<details>
  
<summary>Windows (pwsh)</summary>

> 【重要】NeovimやAlacrittyのパスをLinuxと統一するため、インストール前に必ず環境変数を設定すること。

#### 1. 前提条件のセットアップ (管理者権限で実行)
PowerShellを管理者として開き、以下のコマンドを実行して `XDG_CONFIG_HOME` を設定する。

```powershell
[System.Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "$env:USERPROFILE\.config", "User")
```
設定後はPCの再起動またはサインアウト推奨

#### 2. Chezmoiのインストール
```PowerShell
winget install twpayne.chezmoi
```
インストール後、ターミナルを再起動する。

#### 3. 設定の適用
GitHubから設定を取得し、適用する。

```PowerShell
chezmoi init --apply j22268tm
```

</details>





<details>
<summary>Linux (Fedora / Ubuntu / Debian)</summary>
  
#### 1. Chezmoiのインストール
推奨👇 ワンライナーでいける。一発👊

```Bash
sh -c "$(curl -fsLS get.chezmoi.io)"
```

<details>
  
<summary>パッケージマネージャーを使う場合:</summary>

### Fedora (dnf):
```Bash
sudo dnf install chezmoi
```
### Ubuntu/Debian (apt):

Ubuntuの標準リポジトリには古い場合があるため、Snapまたは公式スクリプト推奨だが、aptで入れる場合は以下。

```Bash
sudo apt update && sudo apt install chezmoi
```

</details> 


#### 2. 設定の適用
```Bash
chezmoi init --apply j22268tm
```

</details>

## 🛠 Usage (運用のしかた)

### 設定を変更したいとき
直接ファイルを編集せず、必ず ```chezmoi edit``` を使うこと。

```Bash
# 例: alacrittyの設定を編集
chezmoi edit ~/.config/alacritty/alacritty.toml
```

保存して閉じると、自動的に```chezmoi apply```が走るらしい

### 手動で変更を適用する (Apply)
テンプレートを編集した後など、強制的に反映させたい場合。
```Bash
chezmoi apply
```

### GitHubに変更をアップロードする
変更をリポジトリに保存する。

```Bash
chezmoi cd
git add .
git commit -m "update config"
git push
exit
```

### 最新の設定を取り込む (Update)
別のPCで更新した設定を、今使っているPCに反映させる。

```Bash
chezmoi update
```
(これは ```git pull``` と ```chezmoi apply``` を同時に行うコマンドらしいです)

## ⚠️ Troubleshooting

### WindowsでAlacrittyの設定が読み込まれない
WindowsのAlacrittyは仕様上 ```XDG_CONFIG_HOME``` を無視して ```%APPDATA%\alacritty``` を見に行く場合がある。
その場合は、シンボリックリンクを作成して騙す必要がある。

```PowerShell
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\alacritty" -Target "$HOME\.config\alacritty"
```

でいけると[巷](https://gemini.google.com)では言われているが、管理者権限を求められるのでJunction推奨
```PowerShell
New-Item -ItemType Junction -Path "$env:APPDATA\alacritty" -Target "$HOME\.config\alacritty"
```

### テンプレートエラーが出る場合
ファイルを追加した際に --template オプションを忘れている可能性がある。 以下のコマンドでテンプレート属性を付与する。

```Bash
chezmoi chattr +template <path/to/file>
```

### 今日は疲れたのでもう寝ます

![Tired](https://media.front.xoedge.com/images/4f0e70c8-9485-4892-b813-6d2dad570813~rs_660.h)

