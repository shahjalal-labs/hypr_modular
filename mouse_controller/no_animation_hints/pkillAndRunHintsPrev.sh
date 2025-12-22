#!/bin/bash
# ~/.local/bin/hints-toggle
if pgrep -x "hints" >/dev/null; then
  pkill -x "hints"
else
  /home/sj/.config/hypr/mouse_controller/no_animation_hints/no_animation_hints.sh
fi
