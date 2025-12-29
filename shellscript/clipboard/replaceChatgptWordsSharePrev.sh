#!/usr/bin/env zsh

# --------------------------------------------------
# Config
# --------------------------------------------------
FILE="/home/sj/knowledge/english/words/wordExplainPrompts/resources/chatgptLinks.md"
EXPECTED_DOMAIN="https://chatgpt.com/share/"
UUID_REGEX='[0-9a-fA-F-]{36}'

# --------------------------------------------------
# Read clipboard (Wayland)
# --------------------------------------------------
CLIPBOARD_CONTENT="$(wl-paste --no-newline 2>/dev/null)"

# --------------------------------------------------
# Validate clipboard existence
# --------------------------------------------------
if [[ -z "$CLIPBOARD_CONTENT" ]]; then
  notify-send "chatgpt Link Update Failed" \
    "Clipboard is empty.\nExpected an SJ Pulse 🚀 share link."
  exit 1
fi

# --------------------------------------------------
# Validate pattern
# --------------------------------------------------
if [[ ! "$CLIPBOARD_CONTENT" =~ ^${EXPECTED_DOMAIN}${UUID_REGEX}$ ]]; then
  notify-send "chatgpt Link Update Failed" \
    "Invalid link detected.\n\nExpected:\n${EXPECTED_DOMAIN}<uuid>"
  exit 1
fi

# --------------------------------------------------
# Replace file content (safe)
# --------------------------------------------------
print -- "$CLIPBOARD_CONTENT" >"$FILE"

# --------------------------------------------------
# Success notification (optional but useful)
# --------------------------------------------------
notify-send "chatgpt Link Updated" \
  "chatgptLinks.md successfully refreshed."
