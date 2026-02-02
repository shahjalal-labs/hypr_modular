#!/bin/bash

# waybar 10 mnts descending timer for session tracking

TIMER_FILE="/tmp/waybar_timer"
DURATION=600 # 10 minutes in seconds

# If a keybind triggers this script with "start", set the start time
if [ "$1" = "start" ]; then
  date +%s >"$TIMER_FILE"
  exit 0
fi

# Normal output for Waybar: calculate remaining time
if [ -f "$TIMER_FILE" ]; then
  START_TIME=$(cat "$TIMER_FILE")
  CURRENT_TIME=$(date +%s)
  ELAPSED=$((CURRENT_TIME - START_TIME))
  REMAINING=$((DURATION - ELAPSED))

  if [ $REMAINING -le 0 ]; then
    rm "$TIMER_FILE"
    echo "00:00"
  else
    MINS=$((REMAINING / 60))
    SECS=$((REMAINING % 60))
    printf "%02d:%02d" $MINS $SECS
  fi
else
  echo "" # Hide if not running
fi
