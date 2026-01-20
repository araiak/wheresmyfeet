# Where's My Feet

A simple World of Warcraft addon that displays a crosshair at your feet.

## Installation

Download the latest release and extract the `WheresMyFeet` folder into your `Interface/AddOns` directory.

## Usage

Type `/wmf` in chat to open the options menu.

### Per-Character Toggle

At the top of the options panel is an **Enabled for this character** checkbox. This allows you to disable the addon for specific characters while keeping it enabled for others. The setting is saved per-character and defaults to enabled.

### Defaults Tab

Configure your default crosshair settings:

- **Y Offset** - Move the crosshair up or down
- **Size** - Adjust the crosshair size
- **Color** - Choose from presets (Green, Red, White, Yellow, Cyan) or click Custom for a full color picker
- **Hide out of combat** - Only show the crosshair during combat (enabled by default)

### Zone Overrides Tab

Configure different crosshair settings for specific dungeons and raids. When you enter a zone with an override, those settings automatically apply. When you leave, settings revert to defaults.

- **Enable zone overrides** - Master toggle for the feature
- **Zone dropdown** - Select from S1 dungeons, discovered zones, or enter a zone ID manually
- **Add Override** - Create an override for the selected zone
- **Override list** - View, enable/disable, edit, or delete configured overrides

Each override has the same settings as the defaults tab:
- Y Offset
- Size
- Color
- Hide out of combat

Changes are saved automatically as you adjust values.

## Slash Commands

| Command | Description |
|---------|-------------|
| `/wmf` | Toggle the options panel |
| `/wmf enable` | Enable for this character |
| `/wmf disable` | Disable for this character |
| `/wmf addzone <id> [name]` | Manually add a zone by ID |
| `/wmf zone` | Show current zone info (for finding zone IDs) |
| `/wmf debug` | Show debug info about current overrides |
| `/wmf reset` | Reset all settings to defaults |

## Supported Versions

- Retail: 11.2.7+
- Beta: 12.0.0, 12.0.1

## License

MIT
