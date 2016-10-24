auraeEffectSelection = ""
local STATUS_COLOR = "|c000066FF"
local AR_DiagOpen = false

local DisplayTable = {}

auraeConfig_SwatchFunc_SetColor = {
	 ["Urge"]	= function(x) aurae_SetColorCallback("Urge") end,
	 ["Low"]	= function(x) aurae_SetColorCallback("Low") end,
	 ["Normal"]	= function(x) aurae_SetColorCallback("Normal") end,
	 ["Effect"]	= function(x) aurae_SetColorCallback("Effect") end,
}

auraeConfig_SwatchFunc_CancelColor = {
	 ["Urge"]	= function(x) aurae_CancelColorCallback("Urge", x) end,
	 ["Low"]	= function(x) aurae_CancelColorCallback("Low", x) end,
	 ["Normal"]	= function(x) aurae_CancelColorCallback("Normal", x) end,
	 ["Effect"]	= function(x) aurae_CancelColorCallback("Effect", x) end,
}

local function SetButtonPickerColor(button, color)
	getglobal(button .. "_SwatchTexture"):SetVertexColor(color.r, color.g, color.b)
	getglobal(button .. "_BorderTexture"):SetVertexColor(color.r, color.g, color.b)
	getglobal(button).r = color.r
	getglobal(button).g = color.g
	getglobal(button).b = color.b
end

function aurae_DisableDropDown(dropDown)
	getglobal(dropDown:GetName() .. "Text"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
	getglobal(dropDown:GetName() .. "Button"):Disable()
end

function aurae_EnableDropDown(dropDown)
	getglobal(dropDown:GetName() .. "Text"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	getglobal(dropDown:GetName() .. "Button"):Enable()
end


function UpdateSortTable()
	DisplayTable = {}
	table.foreach(aurae.EFFECTS, function (k, v) table.insert(DisplayTable, k) end)
	sort(DisplayTable)
end

function auraeOptions_Toggle()
	if(auraeOptionsFrame:IsVisible()) then
		auraeOptionsFrame:Hide()
	else
		auraeOptionsFrame:Show()
	end
end


--------------------------------------------------------------------------------
-- Main Frame
--------------------------------------------------------------------------------

function auraeOptionsBarsTab_OnClick()
	auraeOptionsBarsFrame:Show()
	auraeOptionsEffectsFrame:Hide()
	auraeOptionsLearnFrame:Hide()

	PlaySound"igMainMenuOptionCheckBoxOn"
end

function auraeOptionsEffectsTab_OnClick()
	auraeOptionsBarsFrame:Hide();
	auraeOptionsEffectsFrame:Show();
	auraeOptionsLearnFrame:Hide();

	PlaySound"igMainMenuOptionCheckBoxOn"
end

function auraeOptionsLearnTab_OnClick()
	auraeOptionsBarsFrame:Hide();
	auraeOptionsEffectsFrame:Hide();
	auraeOptionsLearnFrame:Show();

	PlaySound"igMainMenuOptionCheckBoxOn"
end

function auraeOptionsBarsFrame_OnShow()
	auraeOptionsBarsTabTexture:Show()
	auraeOptionsBarsTab:SetBackdropBorderColor(1, 1, 1, 1)
end

function auraeOptionsEffectsFrame_OnShow()
	auraeOptionsEffectsTabTexture:Show()
	auraeOptionsEffectsTab:SetBackdropBorderColor(1, 1, 1, 1)
end

function auraeOptionsLearnFrame_OnShow()
	auraeOptionsLearnTabTexture:Show()
	auraeOptionsLearnTab:SetBackdropBorderColor(1, 1, 1, 1)
end

function auraeOptionsBarsFrame_OnHide()
	auraeOptionsBarsTabTexture:Hide()
	auraeOptionsBarsTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0)
end

function auraeOptionsEffectsFrame_OnHide()
	auraeOptionsEffectsTabTexture:Hide()
	auraeOptionsEffectsTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0)
end

function auraeOptionsLearnFrame_OnHide()
	auraeOptionsLearnTabTexture:Hide()
	auraeOptionsLearnTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0)
end

--------------------------------------------------------------------------------
-- Bars Frame
--------------------------------------------------------------------------------

function auraeOptions_UnlockToggle()
	if aurae.STATUS == 2 then
		aurae_BarLock();
		aurae_Print(aurae_LOCKED);
	else
		aurae_BarUnlock();
		aurae_Print(aurae_UNLOCKED);
	end
end

function auraeOptions_InvertToggle()
	aurae.INVERT = not aurae.INVERT;
	aurae_Save[aurae.PROFILE].invert = aurae.INVERT;
	if aurae.INVERT then
		aurae_Print(aurae_INVERSION_ON);
	else
		aurae_Print(aurae_INVERSION_OFF);
	end
end

function auraeOptions_SetBarColorUrge()
	aurae_Save[aurae.PROFILE].CoTUrgeValue = auraeOptionsBarColorUrgeEdit:GetNumber();
	aurae.COTURGEVALUE = aurae_Save[aurae.PROFILE].CoTUrgeValue;
end

function auraeOptions_SetBarColorLow()
	aurae_Save[aurae.PROFILE].CoTLowValue = auraeOptionsBarColorLowEdit:GetNumber();
	aurae.COTLOWVALUE = aurae_Save[aurae.PROFILE].CoTLowValue;
end

--------------------------------------------------------------------------------
-- Monitor Frame
--------------------------------------------------------------------------------

function auraeOptions_MonitorCCToggle()
	aurae.MONITORING = bit.bxor(aurae.MONITORING, ETYPE_CC)
	aurae_Save[aurae.PROFILE].Monitoring = aurae.MONITORING
	if bit.band(aurae.MONITORING, ETYPE_DEBUFF) == 0 then
		if bit.band(aurae.MONITORING, ETYPE_CC) ~= 0 then
			_F:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
			_F:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		else
			_F:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
			_F:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		end
	end
end

function auraeOptions_MonitorDebuffToggle()
	aurae.MONITORING = bit.bxor(aurae.MONITORING, ETYPE_DEBUFF)
	aurae_Save[aurae.PROFILE].Monitoring = aurae.MONITORING
	if bit.band(aurae.MONITORING, ETYPE_CC) == 0 then
		if bit.band(aurae.MONITORING, ETYPE_DEBUFF) ~= 0 then
			_F:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
			_F:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		else
			_F:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
			_F:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		end
	end
end

function auraeOptions_MonitorBuffToggle()
	aurae.MONITORING = bit.bxor(aurae.MONITORING, ETYPE_BUFF)
	aurae_Save[aurae.PROFILE].Monitoring = aurae.MONITORING
	if bit.band(aurae.MONITORING, ETYPE_BUFF) ~= 0 then
		_F:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"
		_F:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS"
	else
		_F:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"
		_F:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS"
	end
end

function auraeOptions_ArcanistToggle()
	aurae.ARCANIST = not aurae.ARCANIST
	aurae_Save[aurae.PROFILE].arcanist = aurae.ARCANIST
	if aurae.ARCANIST then
		aurae.EFFECTS[aurae_POLYMORPH].DURATION = aurae.EFFECTS[aurae_POLYMORPH].DURATION + 15
		aurae_Print(aurae_ARCANIST_ON)
	else
		aurae.EFFECTS[aurae_POLYMORPH].DURATION = aurae.EFFECTS[aurae_POLYMORPH].DURATION - 15
		aurae_Print(aurae_ARCANIST_OFF)
	end
	auraeOptionsFrameArcanist:SetChecked(aurae.ARCANIST)
end

function auraeOptionsStyleDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "aurae_OptionsStyleDropDown"
	local info = {}

	info.text = aurae_OPTION_STYLE_RECENT
	info.value = "recent"
	info.owner = this
	info.func = auraeOptionsStyleDropDown_OnClick
	UIDropDownMenu_AddButton(info)

	info.text = aurae_OPTION_STYLE_ALL
	info.value = "all"
	info.owner = this
	info.func = auraeOptionsStyleDropDown_OnClick
	UIDropDownMenu_AddButton(info)
end

function auraeOptionsStyleDropDown_OnClick()
	if this.value == "recent" then
		aurae_Save[aurae.PROFILE].style = 1
		aurae.STYLE = aurae_Save[aurae.PROFILE].style
		auraeOptionsStyleDropDownText:SetText(aurae_OPTION_STYLE_RECENT)
		aurae_Print(aurae_STYLE_RECENT)
	elseif this.value == "all" then
		aurae_Save[aurae.PROFILE].style = 2
		aurae.STYLE = aurae_Save[aurae.PROFILE].style
		auraeOptionsStyleDropDownText:SetText(aurae_OPTION_STYLE_ALL)
		aurae_Print(aurae_STYLE_ALL)
	end
end

--------------------------------------------------------------------------------
-- Learn Frame
--------------------------------------------------------------------------------

function auraeOptions_MonitorToggle()
end

function auraeOptionsLearnModify_OnClick()
	local monitor = auraeOptionsEffectMonitor:GetChecked()
	local color = {
		r = auraeOptionsBarColorEffect.r,
		g = auraeOptionsBarColorEffect.g,
		b = auraeOptionsBarColorEffect.b,
	}
	aurae_ModifyEffect(auraeEffectSelection, monitor, color)
end

--------------------------------------------------------------------------------
-- Custom effect management
--------------------------------------------------------------------------------

function aurae_ModifyEffect(effect, monitor, color)
	aurae_Save[aurae.PROFILE].ConfCC[effect] = {
		MONITOR = monitor,
		COLOR = color,
	}
	aurae_LoadConfCCs()
end

function aurae_SetColorCallback(id)
	local iRed, iGreen, iBlue = ColorPickerFrame:GetColorRGB()
	local swatch, button, border

	button = getglobal("auraeOptionsBarColor" .. id)
	swatch = getglobal("auraeOptionsBarColor" .. id .. "_SwatchTexture")
	border = getglobal("auraeOptionsBarColor" .. id .. "_BorderTexture")

	swatch:SetVertexColor(iRed, iGreen, iBlue)
	border:SetVertexColor(iRed, iGreen, iBlue)
	button.r = iRed
	button.g = iGreen
	button.b = iBlue

	if id == "Urge" then
		aurae.COTURGECOLOR.r = iRed
		aurae.COTURGECOLOR.g = iGreen
		aurae.COTURGECOLOR.b = iBlue
		aurae_Save[aurae.PROFILE].CoTUrgeColor = aurae.COTURGECOLOR
	elseif id == "Low" then
		aurae.COTLOWCOLOR.r = iRed
		aurae.COTLOWCOLOR.g = iGreen
		aurae.COTLOWCOLOR.b = iBlue
		aurae_Save[aurae.PROFILE].CoTLowColor = aurae.COTLOWCOLOR
	elseif id == "Normal" then
		aurae.COTNORMALCOLOR.r = iRed
		aurae.COTNORMALCOLOR.g = iGreen
		aurae.COTNORMALCOLOR.b = iBlue
		aurae_Save[aurae.PROFILE].CoTNormalColor = aurae.COTNORMALCOLOR
	end
end

function aurae_CancelColorCallback(id, prev)
	local iRed = prev.r
	local iGreen = prev.g
	local iBlue = prev.b

	local swatch, button, border

	button = getglobal("auraeOptionsBarColor" .. id)
	swatch = getglobal("auraeOptionsBarColor" .. id .. "_SwatchTexture")
	border = getglobal("auraeOptionsBarColor" .. id .. "_BorderTexture")
	
	swatch:SetVertexColor(iRed, iGreen, iBlue);
	border:SetVertexColor(iRed, iGreen, iBlue);
	button.r = iRed;
	button.g = iGreen;
	button.b = iBlue;
end



function auraeOptionsLearnFillFields()
	if auraeEffectSelection == nil then
		return
	end

	auraeOptionsEffectNameStatic:SetText(auraeEffectSelection)
	auraeOptionsEffectDurationStatic:SetText(aurae.EFFECTS[auraeEffectSelection].DURATION)

	if aurae.EFFECTS[auraeEffectSelection].ETYPE == ETYPE_BUFF then
		auraeOptionsEffectType:SetText"BUFF"
	elseif aurae.EFFECTS[auraeEffectSelection].ETYPE == ETYPE_DEBUFF then
		auraeOptionsEffectType:SetText"DEBUFF"
	else
		auraeOptionsEffectType:SetText"CC"
	end

	auraeOptionsBarColorEffect:Enable()
	if aurae.EFFECTS[auraeEffectSelection].COLOR ~= nil then
		SetButtonPickerColor("auraeOptionsBarColorEffect", aurae.EFFECTS[auraeEffectSelection].COLOR)
	else
		SetButtonPickerColor("auraeOptionsBarColorEffect", { r=1, g=1, b=1 })
	end

	auraeOptionsEffectMonitor:SetChecked(aurae.EFFECTS[auraeEffectSelection].MONITOR)
	auraeOptionsEffectMonitor:Enable()
end

function auraeOptions_OnLoad()
	UIPanelWindows.auraeOptionsFrame = { area='center', pushable=1 }
end

--------------------------------------------------------------------------------
-- Init
--------------------------------------------------------------------------------
function auraeOptions_Init()
	auraeSliderAlpha:SetValue(aurae.ALPHA)
	auraeSliderScale:SetValue(aurae.SCALE)

	auraeOptionsFrameMonitorCC:SetChecked(bit.band(aurae.MONITORING, ETYPE_CC))
	auraeOptionsFrameMonitorDebuff:SetChecked(bit.band(aurae.MONITORING, ETYPE_DEBUFF))
	auraeOptionsFrameMonitorBuff:SetChecked(bit.band(aurae.MONITORING, ETYPE_BUFF))

	auraeOptionsFrameUnlock:SetChecked(aurae.STATUS == 2)
	auraeOptionsFrameInvert:SetChecked(aurae.INVERT)
	auraeOptionsFrameArcanist:SetChecked(aurae.ARCANIST)

	auraeOptionsBarColorEffect:Disable()
	auraeOptionsEffectMonitor:Disable()

	if aurae.STYLE == 1 then
		auraeOptionsStyleDropDownText:SetText(aurae_OPTION_STYLE_RECENT)
	else
		auraeOptionsStyleDropDownText:SetText(aurae_OPTION_STYLE_ALL)
	end

	UpdateSortTable()
	auraeOptionsEffects_Update()

	auraeOptionsBarColorEffect.swatchFunc = auraeConfig_SwatchFunc_SetColor.Effect
	auraeOptionsBarColorEffect.cancelFunc = auraeConfig_SwatchFunc_CancelColor.Effect

	auraeOptionsBarsFrame:Show()
	auraeOptionsEffectsTabTexture:Hide()
	auraeOptionsEffectsTab:SetBackdropBorderColor(.25, .25, .25, 1)
	auraeOptionsLearnTabTexture:Hide()
	auraeOptionsLearnTab:SetBackdropBorderColor(.25, .25, .25, 1)
end

--------------------------------------------------------------------------------
-- Scroll Frame functions
--------------------------------------------------------------------------------

local item
local CCcount
local curoffset

local function EffectsUpdate(k, v)
	item = item + 1
	if (curoffset > item) or ((item - curoffset) >= 11) then
		return
	end

	local itemSlot = getglobal("auraeOptionsEffectsItem" .. (item - curoffset + 1))
	if v == auraeEffectSelection then
		itemSlot:SetTextColor(1, 1, 0)
	else
		itemSlot:SetTextColor(1, 1, 1)
	end
	itemSlot:SetText(v)
	itemSlot:Show()
end

function auraeOptionsEffects_Update()
	CCcount = 0

	CCcount = getn(DisplayTable)

	FauxScrollFrame_Update(auraeOptionsEffectsListScrollFrame, CCcount, 11, 16)

	item = -1
	curoffset = FauxScrollFrame_GetOffset(auraeOptionsEffectsListScrollFrame)

	table.foreach(DisplayTable, EffectsUpdate)
end

-- Tooltip Window

function auraeOptionsEffects_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT")

	local spellname = this:GetText()
	if spellname == nil then
		return
	end

	if aurae.EFFECTS[spellname] == nil then
		aurae_Print("Error : '" .. spellname .. "' not found in effect array.")
		return
	end
	local str = spellname .. "\nDuration: " .. aurae.EFFECTS[spellname].DURATION .. "\nType: "
	if aurae.EFFECTS[spellname].ETYPE == ETYPE_BUFF then
		str = str .. "Buff"
	elseif aurae.EFFECTS[spellname].ETYPE == ETYPE_DEBUFF then
		str = str .. "DeBuff"
	else
		str = str .. "CC"
	end
	str = str .. "\nMonitor: "
	if aurae.EFFECTS[spellname].MONITOR then
		str = str .. "on"
	else
		str = str .. "off"
	end

	GameTooltip:SetText(str, 1, 1, 1)
end

-- Confirm dialog frame

function aurae_OpenDiagToggle()
	if (aurae_DiagOpen) then
		aurae_DiagOpen = false
	else
		aurae_DiagOpen = true
	end
end

