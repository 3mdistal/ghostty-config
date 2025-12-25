# Ghostty Config

A JSON-based configuration system for [Ghostty](https://ghostty.org) with automatic light/dark mode switching.

## Features

- **JSON config with schema** - Type-safe configuration with editor autocomplete
- **Light/Dark mode support** - Different configs for each appearance mode
- **Auto-switching** - LaunchAgent watches for macOS appearance changes and regenerates config

## Setup

1. **Install the LaunchAgent** (for auto-switching):
   ```bash
   cp com.alicemoore.ghostty-config.plist ~/Library/LaunchAgents/
   launchctl load ~/Library/LaunchAgents/com.alicemoore.ghostty-config.plist
   ```

2. **Add to your Ghostty config** (`~/.config/ghostty/config` or the Application Support location):
   ```
   config-file = ~/.config/ghostty/generated.conf
   ```

3. **Generate initial config**:
   ```bash
   ./update-config.sh
   ```

## Configuration

Edit `config.json` to customize your Ghostty settings. The schema provides autocomplete in editors like VS Code.

### Structure

```json
{
  "$schema": "./schema.json",
  "font-size": 16,           // Shared settings
  "dark": {
    "theme": "Broadcast",    // Dark mode only
    "background-image": "/path/to/image.jpg"
  },
  "light": {
    "theme": "Belafonte Day" // Light mode only
  }
}
```

- **Top-level keys**: Applied to both modes
- **`dark` object**: Applied only in dark mode
- **`light` object**: Applied only in light mode

## Manual Update

To manually regenerate the config:

```bash
./update-config.sh           # Just generate
./update-config.sh --reload  # Generate and reload Ghostty
```

## Files

- `config.json` - Your configuration (edit this)
- `schema.json` - JSON schema for validation/autocomplete
- `generate.js` - Node.js script that generates Ghostty config
- `update-config.sh` - Shell wrapper script
- `com.alicemoore.ghostty-config.plist` - LaunchAgent for auto-switching
