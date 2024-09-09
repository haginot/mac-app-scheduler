#!/usr/bin/env zsh

# 設定ファイルを読み込む
source /usr/local/etc/myapp/config.sh

while true; do
  CURRENT_TIME=$(date +"%H:%M")

  # 各アプリをループで処理
  for APP_NAME in ${(k)app_times}; do
    # 各アプリの起動時間と終了時間を取得
    TIMES=(${=app_times[$APP_NAME]})
    START_TIME=${TIMES[1]}
    STOP_TIME=${TIMES[2]}

    # 現在時間と比較して、アプリを起動または終了
    if [[ "$CURRENT_TIME" > "$START_TIME" && "$CURRENT_TIME" < "$STOP_TIME" ]]; then
      # アプリが起動していない場合は起動する
      osascript -e "tell application \"$APP_NAME\" to if not running then launch"
      echo "$APP_NAME を起動しました: $CURRENT_TIME"
    else
      # アプリが起動している場合は終了する
      osascript -e "tell application \"$APP_NAME\" to if running then quit"
      echo "$APP_NAME を停止しました: $CURRENT_TIME"
    fi
  done

  # 1分待つ
  sleep 60
done