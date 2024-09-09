# MacAppScheduler

MacAppSchedulerは、macOS上でアプリケーションの起動と終了を自動的にスケジュール管理するツールです。指定した時間にアプリケーションを自動的に起動し、指定した時間に終了させることができます。

## 機能

- 複数のアプリケーションのスケジュール管理
- システム起動時に自動的に開始
- 簡単なインストールと設定

## 必要条件

- macOS 10.13 以降
- zsh シェル (macOSのデフォルトシェル)

## インストール方法

1. このリポジトリをクローンまたはダウンロードします。

```zsh
git clone git@github.com:haginot/mac-app-scheduler.git
cd mac-app-scheduler
```

2. インストールスクリプトを管理者権限で実行します。

```zsh
sudo zsh install_myapp.sh
```

このスクリプトは必要なファイルを適切な場所にコピーし、LaunchAgent を設定します。
管理者パスワードの入力を求められますので、ご注意ください。

## 設定

アプリケーションのスケジュールを設定するには、`/usr/local/etc/myapp/config.sh` ファイルを編集します。

```zsh
sudo nano /usr/local/etc/myapp/config.sh
```

以下の形式でアプリケーションと時間を設定します：

```zsh
app_times=(
  "アプリケーション名1" "開始時間1 終了時間1"
  "アプリケーション名2" "開始時間2 終了時間2"
)
```

例：

```zsh
app_times=(
  "Mail" "09:00 17:00"
  "Slack" "10:00 18:00"
  "Calendar" "08:00 16:00"
)
```

## 設定ファイルの更新について

インストーラーを再実行すると、設定ファイル（`/usr/local/etc/myapp/config.sh`）は新しいバージョンで上書きされます。
ただし、更新前の設定ファイルは自動的にバックアップされます。

カスタム設定を行っている場合は、更新後に再度カスタム設定を適用するか、
バックアップから必要な設定を手動でマージしてください。

バックアップファイルは以下の形式で保存されます：
`/usr/local/etc/myapp/config.sh.YYYYMMDDHHMMSS.bak`

## 使用方法

インストールが完了すると、MacAppScheduler は自動的に起動し、設定されたスケジュールに従ってアプリケーションを管理します。

手動で起動または停止する場合は、以下のコマンドを使用します：

- 起動：

```zsh
launchctl load ~/Library/LaunchAgents/com.example.myapp.plist
```

- 停止：

```zsh
launchctl unload ~/Library/LaunchAgents/com.example.myapp.plist
```

## トラブルシューティング

ログファイルは以下の場所に保存されます：

- 標準出力: `/tmp/myapp_stdout.log`
- 標準エラー出力: `/tmp/myapp_stderr.log`

これらのログファイルを確認することで、問題の原因を特定できる場合があります。