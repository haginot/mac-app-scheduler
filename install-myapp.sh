#!/usr/bin/env zsh

# 設定ファイルを読み込む
source ./config.sh

# スクリプトが管理者権限で実行されているか確認
if [ $UID -ne 0 ]; then
  echo "このスクリプトは管理者権限で実行する必要があります。"
  echo "sudo zsh install_myapp.sh を使用して再実行してください。"
  exit 1
fi

# 変数が未設定の場合のデフォルト値を設定
: ${SCRIPT_DIR:="/usr/local/bin"}
: ${PLIST_DIR:="$HOME/Library/LaunchAgents"}
: ${SCRIPT_NAME:="my-app-manager.sh"}
: ${PLIST_NAME:="com.example.myapp.plist"}

# 1. スクリプトファイルのコピー
echo "Copying script file..."
cp ./my-app-manager.sh "${SCRIPT_DIR}/${SCRIPT_NAME}"
chmod +x "${SCRIPT_DIR}/${SCRIPT_NAME}"
echo "Script file copied to ${SCRIPT_DIR}/${SCRIPT_NAME}"

# 2. 設定ファイルのコピーまたは更新
echo "Updating config file..."
CONFIG_PATH="/usr/local/etc/myapp/config.sh"
if [ -f "$CONFIG_PATH" ]; then
  echo "Existing config file found. Creating backup and updating..."
  cp "$CONFIG_PATH" "${CONFIG_PATH}.$(date +%Y%m%d%H%M%S).bak"
  cp ./config.sh "$CONFIG_PATH"
  echo "Config file updated. Backup created at ${CONFIG_PATH}.*.bak"
else
  echo "No existing config file found. Creating new config..."
  mkdir -p /usr/local/etc/myapp
  cp ./config.sh "$CONFIG_PATH"
  echo "New config file created at $CONFIG_PATH"
fi

# 3. plistファイルのコピー
echo "Copying plist file..."
cp ./com.example.myapp.plist "${PLIST_DIR}/${PLIST_NAME}"

# SUDO_USER が設定されていない場合の対処
if [ -z "$SUDO_USER" ]; then
    echo "Warning: SUDO_USER is not set. Using current user."
    CURRENT_USER=$(whoami)
else
    CURRENT_USER="$SUDO_USER"
fi

# 所有者とグループを設定
chown "${CURRENT_USER}:staff" "${PLIST_DIR}/${PLIST_NAME}"
echo "plist file copied to ${PLIST_DIR}/${PLIST_NAME}"

# 4. 既存のプロセスを終了し、新しいプロセスを開始
echo "Restarting the application..."
if [ -n "$CURRENT_USER" ]; then
    su "$CURRENT_USER" -c "launchctl unload '${PLIST_DIR}/${PLIST_NAME}'"
    su "$CURRENT_USER" -c "launchctl load '${PLIST_DIR}/${PLIST_NAME}'"
else
    echo "Error: Unable to determine the current user. Please restart the application manually."
fi

# 4. 既存のプロセスを終了し、新しいプロセスを開始
echo "Restarting the application..."
su "$SUDO_USER" -c "launchctl unload '${PLIST_DIR}/${PLIST_NAME}'"
su "$SUDO_USER" -c "launchctl load '${PLIST_DIR}/${PLIST_NAME}'"

# 5. 動作確認メッセージ
echo "Installation completed successfully."
echo "The application has been restarted with the new configuration."
echo "You can check the application logs for any issues."