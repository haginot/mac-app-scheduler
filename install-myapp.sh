#!/bin/bash

# 設定ファイルを読み込む
source ./config.sh

# 1. スクリプトファイルのコピー
echo "Copying script file..."
cp ./my_app_manager.sh $SCRIPT_DIR/$SCRIPT_NAME
chmod +x $SCRIPT_DIR/$SCRIPT_NAME
echo "Script file copied to $SCRIPT_DIR/$SCRIPT_NAME"

# 2. plistファイルのコピー
echo "Copying plist file..."
cp ./com.example.myapp.plist $PLIST_DIR/$PLIST_NAME
echo "plist file copied to $PLIST_DIR/$PLIST_NAME"

# 3. launchdにplistを読み込ませる
echo "Loading plist into launchd..."
launchctl load $PLIST_DIR/$PLIST_NAME

# 4. 動作確認メッセージ
echo "Installation completed successfully."
echo "The script will now run automatically at system startup."
