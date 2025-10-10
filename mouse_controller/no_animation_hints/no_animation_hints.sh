#!/bin/bash

# Disable animations
hyprctl keyword animations:enabled false

# Run hints command
/home/sj/.local/bin/hints "$@"

# Wait for hints to appear and then re-enable animations
sleep 0.5
hyprctl keyword animations:enabled true
