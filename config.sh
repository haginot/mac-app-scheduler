#!/usr/bin/env zsh

# インストールディレクトリ
SCRIPT_DIR="/usr/local/bin"
PLIST_DIR="$HOME/Library/LaunchAgents"
SCRIPT_NAME="my_app_manager.sh"
PLIST_NAME="com.example.myapp.plist"

# zshでの連想配列の宣言
typeset -A app_times

# アプリとその起動・終了時間のリスト
app_times=(
  "Weather" "00:00 17:00"
  "Stocks" "00:00 00:20"
  "Books" "00:00 00:30"
)