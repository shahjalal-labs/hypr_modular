#!/usr/bin/env zsh

# --------------------------------------------------
# Config
# --------------------------------------------------
FILE="/home/sj/knowledge/english/words/wordExplainPrompts/resources/chatgptLinks.md"
EXPECTED_DOMAIN="https://chatgpt.com/share/"
UUID_REGEX='[0-9a-fA-F-]{36}'
FULL_REGEX="^${EXPECTED_DOMAIN}${UUID_REGEX}$"

# --------------------------------------------------
# Read clipboard (Wayland)
# --------------------------------------------------
CLIPBOARD_CONTENT="$(wl-paste --no-newline 2>/dev/null)"

# --------------------------------------------------
# Ensure file exists
# --------------------------------------------------
if [[ ! -f "$FILE" ]]; then
  notify-send "chatgpt Link Error" \
    "Source file not found:\n$FILE"
  exit 1
fi

# --------------------------------------------------
# Case 1: Clipboard contains VALID SJ Pulse 🚀 share
# --------------------------------------------------
if [[ -n "$CLIPBOARD_CONTENT" && "$CLIPBOARD_CONTENT" =~ $FULL_REGEX ]]; then
  print -- "$CLIPBOARD_CONTENT" >"$FILE"

  notify-send "chatgpt Link Updated" \
    "File replaced with new share link."

  exit 0
fi

# --------------------------------------------------
# Case 2: Clipboard INVALID → restore from file
# --------------------------------------------------
EXISTING_LINK="$(<"$FILE")"

if [[ "$EXISTING_LINK" =~ $FULL_REGEX ]]; then
  print -- "$EXISTING_LINK" | wl-copy

  notify-send "copied existing Link"
else
  notify-send "SJ Pulse 🚀 Link Error" \
    "Neither clipboard nor file contains a valid SJ Pulse 🚀 share link."
  exit 1
fi
