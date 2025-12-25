#!/bin/bash

# Ghostty Config Updater
# Generates the Ghostty config based on current appearance mode
# and optionally reloads Ghostty.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_JSON="$SCRIPT_DIR/config.json"
OUTPUT_FILE="$HOME/.config/ghostty/generated.conf"

# Ensure output directory exists
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Generate config (use full path for LaunchAgent compatibility)
/opt/homebrew/bin/node "$SCRIPT_DIR/generate.js" "$CONFIG_JSON" "$OUTPUT_FILE"

# Reload Ghostty if running and --reload flag is passed
if [[ "$1" == "--reload" ]]; then
    # Send reload signal to Ghostty (Cmd+Shift+, equivalent via osascript)
    osascript -e 'tell application "System Events" to tell process "Ghostty" to keystroke "," using {command down, shift down}' 2>/dev/null || true
fi
