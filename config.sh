#!/bin/bash

# インストールディレクトリ
SCRIPT_DIR="/usr/local/bin"
PLIST_DIR="$HOME/Library/LaunchAgents"
SCRIPT_NAME="my_app_manager.sh"
PLIST_NAME="com.example.myapp.plist"

# アプリとその起動・終了時間のリスト
declare -A app_times=(
  ["AppName1"]="09:00 17:00"
  ["AppName2"]="10:00 18:00"
  ["AppName3"]="08:00 16:00"
)
