#!/bin/bash

ACTION=$1
shift

if [ "$ACTION" == "create" ]; then
  # Step 3: Called by run-shell. Execute creation.
  TITLE="$1"
  
  # Capture output. 'bugs' is in the path now.
  # We use the previously saved description file.
  if [ ! -f /tmp/gemini_bug_desc ]; then
    tmux display-message "Error: Description file not found."
    exit 1
  fi
  
  OUTPUT=$(cat /tmp/gemini_bug_desc | bugs create --title "$TITLE" --description - 2>&1)
  
  # Sanitize output for tmux display-message
  # - Replace newlines with spaces
  # - Escape single quotes or replace them to avoid breaking the display-message command
  SAFE_MSG=$(echo "$OUTPUT" | tr '\n' ' ' | tr -d "'\"")
  
  tmux display-message "$SAFE_MSG"
fi
