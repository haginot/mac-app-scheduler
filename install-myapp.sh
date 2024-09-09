#!/usr/bin/env zsh

# 設定ファイルを読み込む
source ./config.sh

# スクリプトが管理者権限で実行されているか確認
if [ $UID -ne 0 ]; then
  echo "このスクリプトは管理者権限で実行する必要があります。"
  echo "sudo ./install-myapp.sh を使用して再実行してください。"
  exit 1
fi

# 1. スクリプトファイルのコピー
echo "Copying script file..."
cp ./my-app-manager.sh $SCRIPT_DIR/$SCRIPT_NAME
chmod +x $SCRIPT_DIR/$SCRIPT_NAME
echo "Script file copied to $SCRIPT_DIR/$SCRIPT_NAME"

# 2. 設定ファイルのコピー
echo "Copying config file..."
mkdir -p /usr/local/etc/myapp
cp ./config.sh /usr/local/etc/myapp/config.sh
echo "Config file copied to /usr/local/etc/myapp/config.sh"

# 3. plistファイルのコピー
echo "Copying plist file..."
cp ./com.example.myapp.plist $PLIST_DIR/$PLIST_NAME
chown $SUDO_USER:staff $PLIST_DIR/$PLIST_NAME
echo "plist file copied to $PLIST_DIR/$PLIST_NAME"

# 4. launchdにplistを読み込ませる
echo "Loading plist into launchd..."
su $SUDO_USER -c "launchctl load $PLIST_DIR/$PLIST_NAME"

# 5. 動作確認メッセージ
echo "Installation completed successfully."
echo "The script will now run automatically at system startup."