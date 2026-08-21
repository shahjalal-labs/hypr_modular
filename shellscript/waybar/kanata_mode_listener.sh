#!/usr/bin/env bash
# ~/.config/hypr/shellscript/waybar/kanata_mode_listener.sh
#
# Connects to kanata's TCP server and listens for LayerChange events.
# Every time you switch kanata layers (base/mouse/numbermode/capsnav),
# this writes a short label to a file that waybar polls and displays.
#
# Requires kanata to be started with the TCP server enabled, e.g.:
#   kanata -p 5829 -c /path/to/your/kanata.kbd
#
# Run this script once in the background (see hyprland.conf exec-once
# note below) -- it stays running and updates the file continuously.

PORT=5829
OUT_FILE="/tmp/kanata_mode"

# Map kanata layer names -> short labels shown in the bar.
# Edit these if you rename a layer or want different text.
declare -A LABELS=(
  [base]="NORM"
  [mouse]="MOUSE"
  [numbermode]="NUM"
  [capsnav]="HYPER"
)

# Default label before the first LayerChange event arrives.
echo "NORM" >"$OUT_FILE"

# Reconnect loop: if kanata restarts, keep retrying instead of dying.
while true; do
  nc 127.0.0.1 "$PORT" 2>/dev/null | while IFS= read -r line; do
    layer=$(echo "$line" | grep -oP '"new":"\K[^"]+')
    if [ -n "$layer" ]; then
      label="${LABELS[$layer]:-$layer}"
      echo "$label" >"$OUT_FILE"
    fi
  done
  sleep 2
done
