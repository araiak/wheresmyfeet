# Testing Checklist

Manual test scenarios for Where's My Feet addon.

## Fresh Install

- [ ] Install addon with no existing SavedVariables
- [ ] `/wmf` opens options panel
- [ ] Crosshair appears at default position (green, centered, y=-40)
- [ ] "Hide out of combat" is enabled by default
- [ ] Crosshair hidden out of combat, visible in combat

## Defaults Tab

- [ ] Y Offset slider moves crosshair up/down (-200 to 50)
- [ ] Size slider changes crosshair size (5 to 50)
- [ ] Color presets change crosshair color immediately:
  - [ ] Green
  - [ ] Red
  - [ ] White
  - [ ] Yellow
  - [ ] Cyan
- [ ] Custom color opens color picker
- [ ] Color picker changes apply to crosshair
- [ ] Color swatch updates to show current color
- [ ] "Hide out of combat" toggle works
- [ ] Settings persist after `/reload`

## Zone Overrides Tab

### Master Toggle
- [ ] "Enable zone overrides" checkbox toggles feature
- [ ] When disabled, overrides don't apply even when in instance

### Adding Overrides
- [ ] Dropdown shows current zone at top (when in instance)
- [ ] Dropdown shows S1 dungeons/raids
- [ ] Dropdown shows previously discovered zones
- [ ] "Add" button creates override for selected zone
- [ ] New override appears in list below
- [ ] New override copies current default settings

### Override List
- [ ] Each override shows zone name
- [ ] Enable checkbox toggles individual override
- [ ] "Edit" button opens editor for that override
- [ ] "X" button deletes override (with confirmation)

### Override Editor
- [ ] Shows zone name in title
- [ ] Y Offset slider works
- [ ] Size slider works
- [ ] Color presets work
- [ ] Custom color picker works
- [ ] "Hide out of combat" toggle works
- [ ] "Done" button closes editor
- [ ] Changes save automatically (no save button needed)

## Zone Detection

### Entering Instance
- [ ] Enter a dungeon with an enabled override
- [ ] Chat message: "Zone override active for [Zone Name]"
- [ ] Crosshair updates to override settings
- [ ] Zone auto-discovered and added to dropdown

### Leaving Instance
- [ ] Leave the instance (hearth/port out)
- [ ] Chat message: "Using default settings"
- [ ] Crosshair reverts to default settings

### Edge Cases
- [ ] Login while inside instance - override applies after ~0.5s
- [ ] `/reload` inside instance - override applies
- [ ] Rapid zone changes (portals) - correct override applies
- [ ] Override disabled - entering zone uses defaults
- [ ] Master toggle disabled - all overrides ignored

## Slash Commands

- [ ] `/wmf` - toggles options panel
- [ ] `/wmf zone` - prints current zone name and ID
- [ ] `/wmf debug` - prints override status and effective settings
- [ ] `/wmf addzone 123 Test Zone` - manually adds zone
- [ ] `/wmf reset` - resets all settings (with confirmation)

## Settings Migration

- [ ] User with v1.0.0 settings (flat structure) upgrades to v1.0.1
- [ ] Old settings preserved as new defaults
- [ ] No errors on load

## UI Edge Cases

- [ ] Panel closes with Escape key
- [ ] Panel position resets if dragged off-screen
- [ ] Switching tabs preserves settings
- [ ] Opening panel while in instance shows correct current zone
- [ ] Zone change while panel open updates dropdown

## Combat Visibility

| Scenario | hideOutOfCombat ON | hideOutOfCombat OFF |
|----------|-------------------|---------------------|
| Out of combat | Hidden | Visible |
| In combat | Visible | Visible |
| Options open | Visible | Visible |

## CI Checks

These run automatically on push/PR:

- [ ] `luacheck *.lua` passes with no errors
