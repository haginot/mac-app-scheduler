# config.template.sh
# Copy this file to config.sh and fill in your values

# インストールディレクトリ
SCRIPT_DIR="/path/to/bin"  # Replace this with the actual directory
PLIST_DIR="$HOME/Library/LaunchAgents"
SCRIPT_NAME="my-app-manager.sh"
PLIST_NAME="com.example.myapp.plist"

# zshでの連想配列の宣言
typeset -A app_times
typeset -A app_days

# アプリとその起動・終了時間のリスト
app_times=(
  "Weather" "00:00 17:00"
  "MINAGINE Timestamp" "09:00 20:00"
)

# アプリとその起動曜日 (Mon, Tue, Wed, Thu, Fri, Sat, Sun)
app_days=(
  "Weather" "Mon"
  "MINAGINE Timestamp" "Mon"
)