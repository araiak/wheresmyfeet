-- Defaults
local defaults = {
    yOffset = -40,
    color = {0, 1, 0, 0.9},  -- green
    lineLength = 10,
    lineThickness = 1,
    hideOutOfCombat = true,
}

-- Main frame
local frame = CreateFrame("Frame", "WheresMyFeetFrame", UIParent)
frame:SetSize(48, 48)

local hLine = frame:CreateTexture(nil, "OVERLAY")
local vLine = frame:CreateTexture(nil, "OVERLAY")

local function UpdateCrosshair()
    local db = WheresMyFeetDB or defaults

    frame:ClearAllPoints()
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, db.yOffset)

    hLine:SetColorTexture(unpack(db.color))
    hLine:SetSize(db.lineLength * 2, db.lineThickness)
    hLine:SetPoint("CENTER", frame, "CENTER", 0, 0)

    vLine:SetColorTexture(unpack(db.color))
    vLine:SetSize(db.lineThickness, db.lineLength * 2)
    vLine:SetPoint("CENTER", frame, "CENTER", 0, 0)
end

local function UpdateVisibility()
    local db = WheresMyFeetDB or defaults
    local optionsOpen = WheresMyFeetOptions and WheresMyFeetOptions:IsShown()
    if optionsOpen then
        frame:Show()
    elseif db.hideOutOfCombat and not UnitAffectingCombat("player") then
        frame:Hide()
    else
        frame:Show()
    end
end

-- Combat events
local combatFrame = CreateFrame("Frame")
combatFrame:RegisterEvent("PLAYER_REGEN_DISABLED")  -- entering combat
combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED")   -- leaving combat
combatFrame:SetScript("OnEvent", function()
    UpdateVisibility()
end)

-- Options panel
local options = CreateFrame("Frame", "WheresMyFeetOptions", UIParent, "BackdropTemplate")
options:SetSize(220, 310)
options:SetPoint("CENTER")
options:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = {left = 8, right = 8, top = 8, bottom = 8}
})
options:SetMovable(true)
options:EnableMouse(true)
options:RegisterForDrag("LeftButton")
options:SetScript("OnDragStart", options.StartMoving)
options:SetScript("OnDragStop", options.StopMovingOrSizing)
options:SetScript("OnShow", function() UpdateVisibility() end)
options:SetScript("OnHide", function() UpdateVisibility() end)
options:Hide()

local title = options:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", 0, -15)
title:SetText("Where's My Feet")

-- Close button
local closeBtn = CreateFrame("Button", nil, options, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", -5, -5)

-- Y Offset slider
local ySlider = CreateFrame("Slider", "WMFYSlider", options, "OptionsSliderTemplate")
ySlider:SetPoint("TOP", 0, -60)
ySlider:SetMinMaxValues(-300, 100)
ySlider:SetValueStep(5)
ySlider:SetObeyStepOnDrag(true)
ySlider:SetWidth(180)
WMFYSliderText:SetText("Y Offset")
WMFYSliderLow:SetText("-300")
WMFYSliderHigh:SetText("100")

local yValue = options:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
yValue:SetPoint("TOP", ySlider, "BOTTOM", 0, -2)

ySlider:SetScript("OnValueChanged", function(self, value)
    WheresMyFeetDB.yOffset = value
    yValue:SetText(math.floor(value))
    UpdateCrosshair()
end)

-- Size slider
local sizeSlider = CreateFrame("Slider", "WMFSizeSlider", options, "OptionsSliderTemplate")
sizeSlider:SetPoint("TOP", 0, -120)
sizeSlider:SetMinMaxValues(5, 50)
sizeSlider:SetValueStep(1)
sizeSlider:SetObeyStepOnDrag(true)
sizeSlider:SetWidth(180)
WMFSizeSliderText:SetText("Size")
WMFSizeSliderLow:SetText("5")
WMFSizeSliderHigh:SetText("50")

local sizeValue = options:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
sizeValue:SetPoint("TOP", sizeSlider, "BOTTOM", 0, -2)

sizeSlider:SetScript("OnValueChanged", function(self, value)
    WheresMyFeetDB.lineLength = value
    sizeValue:SetText(math.floor(value))
    UpdateCrosshair()
end)

-- Color buttons
local colorLabel = options:CreateFontString(nil, "OVERLAY", "GameFontNormal")
colorLabel:SetPoint("TOP", 0, -175)
colorLabel:SetText("Color")

local colors = {
    {name = "Green", color = {0, 1, 0, 0.9}},
    {name = "Red", color = {1, 0, 0, 0.9}},
    {name = "White", color = {1, 1, 1, 0.9}},
    {name = "Yellow", color = {1, 1, 0, 0.9}},
    {name = "Cyan", color = {0, 1, 1, 0.9}},
}

local colorBtns = {}
for i, c in ipairs(colors) do
    local btn = CreateFrame("Button", nil, options, "UIPanelButtonTemplate")
    btn:SetSize(40, 22)
    btn:SetText(c.name:sub(1, 1))
    btn:SetPoint("TOP", colorLabel, "BOTTOM", (i - 3) * 42, -5)
    btn:SetScript("OnClick", function()
        WheresMyFeetDB.color = c.color
        UpdateCrosshair()
    end)
    colorBtns[i] = btn
end

-- Custom color picker button
local customBtn = CreateFrame("Button", nil, options, "UIPanelButtonTemplate")
customBtn:SetSize(70, 22)
customBtn:SetText("Custom")
customBtn:SetPoint("TOP", colorLabel, "BOTTOM", 0, -35)
customBtn:SetScript("OnClick", function()
    local r, g, b, a = unpack(WheresMyFeetDB.color)

    local function OnColorChanged()
        local newR, newG, newB = ColorPickerFrame:GetColorRGB()
        local newA = ColorPickerFrame:GetColorAlpha()
        WheresMyFeetDB.color = {newR, newG, newB, newA}
        UpdateCrosshair()
    end

    local function OnCancel()
        WheresMyFeetDB.color = {r, g, b, a}
        UpdateCrosshair()
    end

    ColorPickerFrame:SetupColorPickerAndShow({
        r = r, g = g, b = b, opacity = a,
        hasOpacity = true,
        swatchFunc = OnColorChanged,
        opacityFunc = OnColorChanged,
        cancelFunc = OnCancel,
    })
end)

-- Hide out of combat checkbox
local combatCheck = CreateFrame("CheckButton", "WMFCombatCheck", options, "UICheckButtonTemplate")
combatCheck:SetPoint("TOPLEFT", options, "TOPLEFT", 25, -260)
combatCheck.text = combatCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
combatCheck.text:SetPoint("LEFT", combatCheck, "RIGHT", 5, 0)
combatCheck.text:SetText("Hide out of combat")
combatCheck:SetScript("OnClick", function(self)
    WheresMyFeetDB.hideOutOfCombat = self:GetChecked()
    UpdateVisibility()
end)

-- Initialize on load
local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, event, addon)
    if addon == "WheresMyFeet" then
        WheresMyFeetDB = WheresMyFeetDB or CopyTable(defaults)
        -- Ensure all keys exist
        for k, v in pairs(defaults) do
            if WheresMyFeetDB[k] == nil then
                WheresMyFeetDB[k] = v
            end
        end
        UpdateCrosshair()
        UpdateVisibility()
        ySlider:SetValue(WheresMyFeetDB.yOffset)
        sizeSlider:SetValue(WheresMyFeetDB.lineLength)
        combatCheck:SetChecked(WheresMyFeetDB.hideOutOfCombat)
    end
end)

-- Slash command
SLASH_WHERESYMFEET1 = "/wmf"
SlashCmdList["WHERESYMFEET"] = function(msg)
    if options:IsShown() then
        options:Hide()
    else
        options:Show()
    end
end
