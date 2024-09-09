# MacAppScheduler

MacAppScheduler は、macOS 上でアプリケーションの起動と終了を自動的にスケジュール管理するツールです。指定した時間にアプリケーションを自動的に起動し、指定した時間に終了させることができます。

## 機能

- 複数のアプリケーションのスケジュール管理
- システム起動時に自動的に開始
- 簡単なインストールと設定

## 必要条件

- macOS 10.13 以降
- Bash シェル

## インストール方法

1. このリポジトリをクローンまたはダウンロードします。

```bash
git clone https://github.com/yourusername/MacAppScheduler.git
cd MacAppScheduler
```

2. インストールスクリプトを実行します。

```bash
bash install_myapp.sh
```

このスクリプトは必要なファイルを適切な場所にコピーし、LaunchAgent を設定します。

## 設定

アプリケーションのスケジュールを設定するには、`config.sh` ファイルを編集します。

```bash
nano /usr/local/etc/myapp/config.sh
```

以下の形式でアプリケーションと時間を設定します：

```bash
declare -A app_times=(
  ["アプリケーション名"]="開始時間 終了時間"
)
```

例：

```bash
declare -A app_times=(
  ["Mail"]="09:00 17:00"
  ["Slack"]="10:00 18:00"
  ["Calendar"]="08:00 16:00"
)
```

## 使用方法

インストールが完了すると、MacAppScheduler は自動的に起動し、設定されたスケジュールに従ってアプリケーションを管理します。

手動で起動または停止する場合は、以下のコマンドを使用します：

- 起動：

```bash
launchctl load ~/Library/LaunchAgents/com.example.myapp.plist
```

- 停止：

```bash
launchctl unload ~/Library/LaunchAgents/com.example.myapp.plist
```

## トラブルシューティング

ログファイルは以下の場所に保存されます：

- 標準出力: `/tmp/myapp_stdout.log`
- 標準エラー出力: `/tmp/myapp_stderr.log`

これらのログファイルを確認することで、問題の原因を特定できる場合があります。