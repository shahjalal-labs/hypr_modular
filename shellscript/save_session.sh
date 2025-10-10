#!/bin/bash

# Simple save - just workspace and app class
hyprctl clients -j | jq -r '.[] | "\(.workspace.id) \(.class)"' > ~/.hypr-session

notify-send "💾 Session Saved" "Ready for next restore"
