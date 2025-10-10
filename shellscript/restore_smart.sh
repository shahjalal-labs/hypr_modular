#!/bin/bash

SESSION_FILE="$HOME/.hypr-session"

echo "=== DEBUG MODE ==="
echo "Session file exists: $(test -f "$SESSION_FILE" && echo "YES" || echo "NO")"
echo "Content:"
cat "$SESSION_FILE"
echo "=================="

if [ ! -f "$SESSION_FILE" ]; then
    notify-send "❌ No session file at $SESSION_FILE"
    exit 1
fi

# Simple one-by-one restore
while read -r workspace class width height pos_x pos_y floating; do
    echo "RESTORING: ws$workspace | $class | ${width}x${height} | pos($pos_x,$pos_y) | float:$floating"
    
    # Just launch in correct workspace first
    hyprctl dispatch workspace "$workspace"
    sleep 1
    
    case "$class" in
        "firefox") firefox & ;;
        "kitty") kitty & ;;
        "google-chrome") google-chrome-stable & ;;
        "Postman") postman & ;;
    esac
    
    sleep 2
done < "$SESSION_FILE"

notify-send "✅ Basic Restore Done" "Apps launched in workspaces"
