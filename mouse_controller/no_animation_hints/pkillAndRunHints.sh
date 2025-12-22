#!/bin/bash
# /home/sj/.config/hypr/mouse_controller/no_animation_hints/pkillAndRunHints.sh

# Ensure daemon is running
if ! pgrep -x "hintsd" >/dev/null; then
  hintsd &
  sleep 0.5
fi

# Disable animations
hyprctl keyword animations:enabled false

# Run hints - it might handle multiple instances internally
/home/sj/.local/bin/hints "$@"

# Re-enable animations
hyprctl keyword animations:enabled true
