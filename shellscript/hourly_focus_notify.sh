#!/usr/bin/env zsh

# notify after every 8 am, 9am, 10 am, 11pm remember me to breath
# Target hours (24-hour format)
hours=(8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 0)

# Infinite loop
while true; do
  current_hour=$(date +%H | sed 's/^0//') # remove leading zero

  for h in "${hours[@]}"; do
    if [ "$current_hour" -eq "$h" ]; then
      # Format hour in 12h AM/PM
      display_hour=$(date -d "$h:00" +"%-I %p")

      notify-send "$display_hour: Breathe for 10 mins, reborn, flashback, modify"

      # Sleep 3600s (1 hour) to avoid multiple notifications in the same hour
      sleep 3600
    fi
  done

  # Check every 60 seconds
  sleep 60
done
