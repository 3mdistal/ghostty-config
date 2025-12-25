#!/bin/bash

# Ghostty Config Watcher
# Uses fswatch for near-instant config regeneration on file changes

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UPDATE_SCRIPT="$SCRIPT_DIR/update-config.sh"

# Files to watch
CONFIG_JSON="$SCRIPT_DIR/config.json"
GLOBAL_PREFS="$HOME/Library/Preferences/.GlobalPreferences.plist"

# Run update once at start
"$UPDATE_SCRIPT"

# Watch for changes and regenerate
# -o: one event per batch (don't spam on multiple rapid changes)
# -l 0.2: latency of 0.2 seconds (debounce rapid changes)
/opt/homebrew/bin/fswatch -o -l 0.2 "$CONFIG_JSON" "$GLOBAL_PREFS" | while read -r; do
    "$UPDATE_SCRIPT" --reload
done
