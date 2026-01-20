-- Luacheck configuration for WoW addons
std = "lua51"
max_line_length = false
codes = true

-- Ignore some common patterns
ignore = {
    "212",  -- Unused argument (common in event handlers)
    "213",  -- Unused loop variable
    "221",  -- Variable never set (forward declarations)
    "241",  -- Variable mutated but never accessed (UI element tables)
}

-- Global objects defined by this addon
globals = {
    "WheresMyFeetDB",
    "WheresMyFeetCharDB",
    "SLASH_WMF1",
    "SLASH_WHERESYMFEET1",
    "SlashCmdList",
    "StaticPopupDialogs",  -- addon adds dialogs to this table

    -- Frame names (auto-created children from slider templates)
    "WheresMyFeetOptions",
    "WMFYSlider",
    "WMFYSliderText",
    "WMFYSliderLow",
    "WMFYSliderHigh",
    "WMFSizeSlider",
    "WMFSizeSliderText",
    "WMFSizeSliderLow",
    "WMFSizeSliderHigh",
    "WMFEditorYSlider",
    "WMFEditorYSliderText",
    "WMFEditorYSliderLow",
    "WMFEditorYSliderHigh",
    "WMFEditorSizeSlider",
    "WMFEditorSizeSliderText",
    "WMFEditorSizeSliderLow",
    "WMFEditorSizeSliderHigh",
    "WMFEnabledCheck",
}

-- WoW API globals (read-only)
read_globals = {
    -- Lua extensions
    "strsplit",
    "strjoin",
    "tinsert",
    "tremove",
    "wipe",
    "format",
    "CopyTable",

    -- Frame and UI
    "CreateFrame",
    "UIParent",
    "GameFontNormal",
    "GameFontNormalSmall",
    "GameFontHighlight",
    "GameFontHighlightSmall",
    "GameFontNormalLarge",
    "UIDropDownMenu_Initialize",
    "UIDropDownMenu_CreateInfo",
    "UIDropDownMenu_AddButton",
    "UIDropDownMenu_SetWidth",
    "UIDropDownMenu_SetText",
    "UIDropDownMenu_SetSelectedValue",
    "UIDropDownMenu_GetSelectedValue",
    "UIDropDownMenu_AddSeparator",
    "ToggleDropDownMenu",
    "CloseDropDownMenus",
    "ColorPickerFrame",
    "ColorPickerOkayButton",
    "OpacitySliderFrame",
    "UIDROPDOWNMENU_MENU_VALUE",

    -- Events
    "C_Timer",

    -- Instance/Zone info
    "GetInstanceInfo",
    "GetZoneText",
    "GetRealZoneText",
    "GetSubZoneText",
    "C_Map",

    -- Player info
    "UnitAffectingCombat",

    -- Chat
    "print",
    "DEFAULT_CHAT_FRAME",

    -- Sound
    "PlaySound",
    "SOUNDKIT",

    -- Settings/Variables
    "InterfaceOptionsFrame_OpenToCategory",
    "Settings",

    -- Misc
    "GetAddOnMetadata",
    "IsAddOnLoaded",
    "C_AddOns",
    "StaticPopup_Show",
    "ReloadUI",
}
