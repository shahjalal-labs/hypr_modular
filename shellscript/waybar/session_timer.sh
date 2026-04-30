#!/usr/bin/env bash
# ~/.config/hypr/shellscript/waybar/session_timer.sh

# Start Waybar timer script
~/.config/hypr/shellscript/waybar/waybar-timer.sh start

# Send first notification (immediate)
notify-send "Bis. $(date '+%-I:%M:%S %p')" "Follow the sy. Life is struggle. Focus."

# Optional: session tracker
# /home/sj/dotfiles-sj/zshScript/shellScript/sessionTracker.sh

# Schedule subsequent notifications in the background
(sleep 300 && notify-send "Mid." "Wake up, tavao and roar.") &



(sleep 600 && notify-send "Alh $(date '+%-I:%M:%S %p')" "Breathe. Think Deeply. One minute of deep thinking & focus can unlock a year's productivity.") &
