#!/bin/bash

SESSION_FILE="$HOME/.hypr-session"

if [ ! -f "$SESSION_FILE" ]; then
    notify-send "❌ No saved session"
    exit 1
fi

notify-send "🔄 Restoring Session" "Starting applications..."

while read -r workspace app_class; do
    echo "Launching $app_class on workspace $workspace"
    
    # Switch to workspace first
    hyprctl dispatch workspace "$workspace"
    sleep 0.5
    
    # Launch application
    case "$app_class" in
        "firefox") firefox & ;;
        "kitty") kitty & ;;
        "google-chrome") google-chrome-stable & ;;
        "Postman") postman & ;;
        *) echo "Unknown app: $app_class" ;;
    esac
    
    sleep 1
done < "$SESSION_FILE"

notify-send "✅ Session Restored" "All apps launched in their workspaces!"
