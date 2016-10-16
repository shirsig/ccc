CCWatchEffectSelection = ""
local STATUS_COLOR = "|c000066FF"
local AR_DiagOpen = false

local DisplayTable = {}

CCWatchConfig_SwatchFunc_SetColor = {
	 ["Urge"]	= function(x) CCWatch_SetColorCallback("Urge") end,
	 ["Low"]	= function(x) CCWatch_SetColorCallback("Low") end,
	 ["Normal"]	= function(x) CCWatch_SetColorCallback("Normal") end,
	 ["Effect"]	= function(x) CCWatch_SetColorCallback("Effect") end,
}

CCWatchConfig_SwatchFunc_CancelColor = {
	 ["Urge"]	= function(x) CCWatch_CancelColorCallback("Urge", x) end,
	 ["Low"]	= function(x) CCWatch_CancelColorCallback("Low", x) end,
	 ["Normal"]	= function(x) CCWatch_CancelColorCallback("Normal", x) end,
	 ["Effect"]	= function(x) CCWatch_CancelColorCallback("Effect", x) end,
}

local function SetButtonPickerColor(button, color)
	getglobal(button .. "_SwatchTexture"):SetVertexColor(color.r, color.g, color.b)
	getglobal(button .. "_BorderTexture"):SetVertexColor(color.r, color.g, color.b)
	getglobal(button).r = color.r
	getglobal(button).g = color.g
	getglobal(button).b = color.b
end

function CCWatch_DisableDropDown(dropDown)
	getglobal(dropDown:GetName() .. "Text"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
	getglobal(dropDown:GetName() .. "Button"):Disable()
end

function CCWatch_EnableDropDown(dropDown)
	getglobal(dropDown:GetName() .. "Text"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	getglobal(dropDown:GetName() .. "Button"):Enable()
end


function UpdateSortTable()
	DisplayTable = {}
	table.foreach(CCWATCH.CCS, function (k, v) table.insert(DisplayTable, k) end)
	sort(DisplayTable)
end

function CCWatchOptions_Toggle()
	if(CCWatchOptionsFrame:IsVisible()) then
		CCWatchOptionsFrame:Hide()
	else
		CCWatchOptionsFrame:Show()
	end
end


--------------------------------------------------------------------------------
-- Main Frame
--------------------------------------------------------------------------------

function CCWatchOptionsBarsTab_OnClick()
	CCWatchOptionsBarsFrame:Show()
	CCWatchOptionsEffectsFrame:Hide()
	CCWatchOptionsLearnFrame:Hide()

	PlaySound"igMainMenuOptionCheckBoxOn"
end

function CCWatchOptionsEffectsTab_OnClick()
	CCWatchOptionsBarsFrame:Hide();
	CCWatchOptionsEffectsFrame:Show();
	CCWatchOptionsLearnFrame:Hide();

	PlaySound"igMainMenuOptionCheckBoxOn"
end

function CCWatchOptionsLearnTab_OnClick()
	CCWatchOptionsBarsFrame:Hide();
	CCWatchOptionsEffectsFrame:Hide();
	CCWatchOptionsLearnFrame:Show();

	PlaySound"igMainMenuOptionCheckBoxOn"
end

function CCWatchOptionsBarsFrame_OnShow()
	CCWatchOptionsBarsTabTexture:Show()
	CCWatchOptionsBarsTab:SetBackdropBorderColor(1, 1, 1, 1)
end

function CCWatchOptionsEffectsFrame_OnShow()
	CCWatchOptionsEffectsTabTexture:Show()
	CCWatchOptionsEffectsTab:SetBackdropBorderColor(1, 1, 1, 1)
end

function CCWatchOptionsLearnFrame_OnShow()
	CCWatchOptionsLearnTabTexture:Show()
	CCWatchOptionsLearnTab:SetBackdropBorderColor(1, 1, 1, 1)
end

function CCWatchOptionsBarsFrame_OnHide()
	CCWatchOptionsBarsTabTexture:Hide()
	CCWatchOptionsBarsTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0)
end

function CCWatchOptionsEffectsFrame_OnHide()
	CCWatchOptionsEffectsTabTexture:Hide()
	CCWatchOptionsEffectsTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0)
end

function CCWatchOptionsLearnFrame_OnHide()
	CCWatchOptionsLearnTabTexture:Hide()
	CCWatchOptionsLearnTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0)
end

--------------------------------------------------------------------------------
-- Bars Frame
--------------------------------------------------------------------------------

function CCWatchOptions_UnlockToggle()
	if CCWATCH.STATUS == 2 then
		CCWatch_BarLock();
		CCWatch_AddMessage(CCWATCH_LOCKED);
	else
		CCWatch_BarUnlock();
		CCWatch_AddMessage(CCWATCH_UNLOCKED);
	end
end

function CCWatchOptions_InvertToggle()
	CCWATCH.INVERT = not CCWATCH.INVERT;
	CCWatch_Save[CCWATCH.PROFILE].invert = CCWATCH.INVERT;
	if CCWATCH.INVERT then
		CCWatch_AddMessage(CCWATCH_INVERSION_ON);
	else
		CCWatch_AddMessage(CCWATCH_INVERSION_OFF);
	end
end

function CCWatchOptions_ColorOverTimeToggle()
	CCWATCH.COLOROVERTIME = not CCWATCH.COLOROVERTIME;
	CCWatch_Save[CCWATCH.PROFILE].ColorOverTime = CCWATCH.COLOROVERTIME;
	if CCWATCH.COLOROVERTIME then
		CCWatch_AddMessage(CCWATCH_COLOROVERTIME_ON);
	else
		CCWatch_AddMessage(CCWATCH_COLOROVERTIME_OFF);
	end
end

function CCWatchOptions_SetBarColorUrge()
	CCWatch_Save[CCWATCH.PROFILE].CoTUrgeValue = CCWatchOptionsBarColorUrgeEdit:GetNumber();
	CCWATCH.COTURGEVALUE = CCWatch_Save[CCWATCH.PROFILE].CoTUrgeValue;
end

function CCWatchOptions_SetBarColorLow()
	CCWatch_Save[CCWATCH.PROFILE].CoTLowValue = CCWatchOptionsBarColorLowEdit:GetNumber();
	CCWATCH.COTLOWVALUE = CCWatch_Save[CCWATCH.PROFILE].CoTLowValue;
end

function CCWatchGrowthDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsMenuGrowthDropDown";
	local info = {}

	info.text = CCWATCH_OPTION_GROWTH_UP
	info.value = "up"
	info.owner = this
	info.func = CCWatchGrowthDropDown_OnClick
	UIDropDownMenu_AddButton(info)
	
	info.text = CCWATCH_OPTION_GROWTH_DOWN
	info.value = "down"
	info.owner = this
	info.func = CCWatchGrowthDropDown_OnClick
	UIDropDownMenu_AddButton(info)
end

function CCWatchGrowthDropDown_OnClick()
	if (this.value == "off") then
		CCWatch_Save[CCWATCH.PROFILE].growth = 0;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_OFF);
		CCWatch_AddMessage(CCWATCH_GROW_OFF);
	elseif( this.value == "up" ) then
		CCWatch_Save[CCWATCH.PROFILE].growth = 1;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_UP);
		CCWatch_AddMessage(CCWATCH_GROW_UP);
	elseif( this.value == "down" ) then
		CCWatch_Save[CCWATCH.PROFILE].growth = 2;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_DOWN);
		CCWatch_AddMessage(CCWATCH_GROW_DOWN);
	end
end

--------------------------------------------------------------------------------
-- Monitor Frame
--------------------------------------------------------------------------------

function CCWatchOptions_MonitorCCToggle()
	CCWATCH.MONITORING = bit.bxor(CCWATCH.MONITORING, ETYPE_CC)
	CCWatch_Save[CCWATCH.PROFILE].Monitoring = CCWATCH.MONITORING
	if bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF) == 0 then
		if bit.band(CCWATCH.MONITORING, ETYPE_CC) ~= 0 then
			CCWatchObject:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
			CCWatchObject:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		else
			CCWatchObject:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
			CCWatchObject:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		end
	end
end

function CCWatchOptions_MonitorDebuffToggle()
	CCWATCH.MONITORING = bit.bxor(CCWATCH.MONITORING, ETYPE_DEBUFF)
	CCWatch_Save[CCWATCH.PROFILE].Monitoring = CCWATCH.MONITORING
	if bit.band(CCWATCH.MONITORING, ETYPE_CC) == 0 then
		if bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF) ~= 0 then
			CCWatchObject:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
			CCWatchObject:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		else
			CCWatchObject:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
			CCWatchObject:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		end
	end
end

function CCWatchOptions_MonitorBuffToggle()
	CCWATCH.MONITORING = bit.bxor(CCWATCH.MONITORING, ETYPE_BUFF)
	CCWatch_Save[CCWATCH.PROFILE].Monitoring = CCWATCH.MONITORING
	if bit.band(CCWATCH.MONITORING, ETYPE_BUFF) ~= 0 then
		CCWatchObject:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"
		CCWatchObject:RegisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS"
	else
		CCWatchObject:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"
		CCWatchObject:UnregisterEvent"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS"
	end
end

function CCWatchOptions_ArcanistToggle()
	CCWATCH.ARCANIST = not CCWATCH.ARCANIST
	CCWatch_Save[CCWATCH.PROFILE].arcanist = CCWATCH.ARCANIST
	if CCWATCH.ARCANIST then
		CCWATCH.CCS[CCWATCH_POLYMORPH].DURATION = CCWATCH.CCS[CCWATCH_POLYMORPH].DURATION + 15
		CCWatch_AddMessage(CCWATCH_ARCANIST_ON)
	else
		CCWATCH.CCS[CCWATCH_POLYMORPH].DURATION = CCWATCH.CCS[CCWATCH_POLYMORPH].DURATION - 15
		CCWatch_AddMessage(CCWATCH_ARCANIST_OFF)
	end
	CCWatchOptionsFrameArcanist:SetChecked(CCWATCH.ARCANIST)
end

function CCWatchOptions_WarnAppliedToggle()
	CCWATCH.WARNMSG = bit.bxor(CCWATCH.WARNMSG, CCW_EWARN_APPLIED)
	CCWatch_Save[CCWATCH.PROFILE].WarnMsg = CCWATCH.WARNMSG
	CCWatchOptionsFrameWarnApplied:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_APPLIED))
end

function CCWatchOptions_WarnFadedToggle()
	CCWATCH.WARNMSG = bit.bxor(CCWATCH.WARNMSG, CCW_EWARN_FADED)
	CCWatch_Save[CCWATCH.PROFILE].WarnMsg = CCWATCH.WARNMSG
	CCWatchOptionsFrameWarnFaded:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_FADED))
end

function CCWatchOptions_WarnBrokenToggle()
	CCWATCH.WARNMSG = bit.bxor(CCWATCH.WARNMSG, CCW_EWARN_BROKEN)
	CCWatch_Save[CCWATCH.PROFILE].WarnMsg = CCWATCH.WARNMSG
	CCWatchOptionsFrameWarnBroken:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_BROKEN))
end

function CCWatchOptions_WarnLowTimeToggle()
	CCWATCH.WARNMSG = bit.bxor(CCWATCH.WARNMSG, CCW_EWARN_LOWTIME)
	CCWatch_Save[CCWATCH.PROFILE].WarnMsg = CCWATCH.WARNMSG
	CCWatchOptionsFrameWarnLowTime:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_LOWTIME))
end

function CCWatchOptions_SetWarnLow()
	CCWatch_Save[CCWATCH.PROFILE].WarnLow = CCWatchOptionsFrameWarnLowEdit:GetNumber()
	CCWATCH.WARNLOW = CCWatch_Save[CCWATCH.PROFILE].WarnLow
end

function CCWatchOptionsStyleDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsStyleDropDown"
	local info = {}

	info.text = CCWATCH_OPTION_STYLE_RECENT
	info.value = "recent"
	info.owner = this
	info.func = CCWatchOptionsStyleDropDown_OnClick
	UIDropDownMenu_AddButton(info)
	
	info.text = CCWATCH_OPTION_STYLE_ALL
	info.value = "all"
	info.owner = this
	info.func = CCWatchOptionsStyleDropDown_OnClick
	UIDropDownMenu_AddButton(info)
end

function CCWatchOptionsStyleDropDown_OnClick()
	if this.value == "recent" then
		CCWatch_Save[CCWATCH.PROFILE].style = 1
		CCWATCH.STYLE = CCWatch_Save[CCWATCH.PROFILE].style
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_RECENT)
		CCWatch_AddMessage(CCWATCH_STYLE_RECENT)
	elseif this.value == "all" then
		CCWatch_Save[CCWATCH.PROFILE].style = 2
		CCWATCH.STYLE = CCWatch_Save[CCWATCH.PROFILE].style
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_ALL)
		CCWatch_AddMessage(CCWATCH_STYLE_ALL)
	end
end


function CCWatchOptionsWarnCCDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsWarnCCDropDown"
	local info = {}

	info.text = "EMOTE"
	info.value = "EMOTE"
	info.owner = this
	info.func = CCWatchOptionsWarnCCDropDown_OnClick
	UIDropDownMenu_AddButton(info)

	info.text = "SAY"
	info.value = "SAY"
	info.owner = this
	info.func = CCWatchOptionsWarnCCDropDown_OnClick
	UIDropDownMenu_AddButton(info)
	
	info.text = "PARTY"
	info.value = "PARTY"
	info.owner = this
	info.func = CCWatchOptionsWarnCCDropDown_OnClick
	UIDropDownMenu_AddButton(info)

	info.text = "RAID"
	info.value = "RAID"
	info.owner = this
	info.func = CCWatchOptionsWarnCCDropDown_OnClick
	UIDropDownMenu_AddButton(info)

	info.text = "YELL"
	info.value = "YELL"
	info.owner = this
	info.func = CCWatchOptionsWarnCCDropDown_OnClick
	UIDropDownMenu_AddButton(info)

	info.text = "CHANNEL"
	info.value = "CHANNEL"
	info.owner = this
	info.func = CCWatchOptionsWarnCCDropDown_OnClick
	UIDropDownMenu_AddButton(info)
end

function CCWatchOptionsWarnCCDropDown_OnClick()
	if (this.value == "EMOTE") or (this.value == "SAY") or (this.value == "PARTY") 
		or (this.value == "RAID") or (this.value == "YELL") or (this.value == "CHANNEL") then
		CCWatch_Save[CCWATCH.PROFILE].WarnType = this.value;
		CCWATCH.WARNTYPE = CCWatch_Save[CCWATCH.PROFILE].WarnType;
		CCWatchOptionsWarnCCDropDownText:SetText(this.value);
		if (this.value == "CHANNEL") then
			CCWatchOptionsFrameCustomCCEdit:Show();
		else
			CCWatchOptionsFrameCustomCCEdit:Hide();
		end
		CCWatch_AddMessage(CCWATCH_WARNCC_SETTO..this.value);
	end
end

function CCWatchOptions_SetCustomCC()
	CCWatch_Save[CCWATCH.PROFILE].WarnCustomCC = CCWatchOptionsFrameCustomCCEdit:GetText();
	CCWATCH.WARNCUSTOMCC = CCWatch_Save[CCWATCH.PROFILE].WarnCustomCC;
end

--------------------------------------------------------------------------------
-- Learn Frame
--------------------------------------------------------------------------------

function CCWatchOptions_MonitorToggle()
end

function CCWatchOptions_WarnToggle()
end

function CCWatchOptionsLearnModify_OnClick()
	local monitor = CCWatchOptionsEffectMonitor:GetChecked()
	local warn = CCWatchOptionsEffectWarn:GetChecked()
	local color = {
		r = CCWatchOptionsBarColorEffect.r,
		g = CCWatchOptionsBarColorEffect.g,
		b = CCWatchOptionsBarColorEffect.b,
	}
	CCWatch_ModifyEffect(CCWatchEffectSelection, monitor, warn, color)
end

--------------------------------------------------------------------------------
-- Custom effect management
--------------------------------------------------------------------------------

function CCWatch_ModifyEffect(effect, monitor, warn, color)
	local iWarn = warn and 1 or 0
	CCWatch_Save[CCWATCH.PROFILE].ConfCC[effect] = {
		MONITOR = monitor,
		WARN = iWarn,
		COLOR = color,
	}
	CCWatch_LoadConfCCs()
end

function CCWatch_SetColorCallback(id)
	local iRed, iGreen, iBlue = ColorPickerFrame:GetColorRGB()
	local swatch, button, border

	button = getglobal("CCWatchOptionsBarColor" .. id)
	swatch = getglobal("CCWatchOptionsBarColor" .. id .. "_SwatchTexture")
	border = getglobal("CCWatchOptionsBarColor" .. id .. "_BorderTexture")

	swatch:SetVertexColor(iRed, iGreen, iBlue)
	border:SetVertexColor(iRed, iGreen, iBlue)
	button.r = iRed
	button.g = iGreen
	button.b = iBlue

	if id == "Urge" then
		CCWATCH.COTURGECOLOR.r = iRed
		CCWATCH.COTURGECOLOR.g = iGreen
		CCWATCH.COTURGECOLOR.b = iBlue
		CCWatch_Save[CCWATCH.PROFILE].CoTUrgeColor = CCWATCH.COTURGECOLOR
	elseif id == "Low" then
		CCWATCH.COTLOWCOLOR.r = iRed
		CCWATCH.COTLOWCOLOR.g = iGreen
		CCWATCH.COTLOWCOLOR.b = iBlue
		CCWatch_Save[CCWATCH.PROFILE].CoTLowColor = CCWATCH.COTLOWCOLOR
	elseif id == "Normal" then
		CCWATCH.COTNORMALCOLOR.r = iRed
		CCWATCH.COTNORMALCOLOR.g = iGreen
		CCWATCH.COTNORMALCOLOR.b = iBlue
		CCWatch_Save[CCWATCH.PROFILE].CoTNormalColor = CCWATCH.COTNORMALCOLOR
	end
end

function CCWatch_CancelColorCallback(id, prev)
	local iRed = prev.r
	local iGreen = prev.g
	local iBlue = prev.b

	local swatch, button, border

	button = getglobal("CCWatchOptionsBarColor" .. id)
	swatch = getglobal("CCWatchOptionsBarColor" .. id .. "_SwatchTexture")
	border = getglobal("CCWatchOptionsBarColor" .. id .. "_BorderTexture")
	
	swatch:SetVertexColor(iRed, iGreen, iBlue);
	border:SetVertexColor(iRed, iGreen, iBlue);
	button.r = iRed;
	button.g = iGreen;
	button.b = iBlue;
end



function CCWatchOptionsLearnFillFields()
	if CCWatchEffectSelection == nil then
		return
	end

	CCWatchOptionsEffectNameStatic:SetText(CCWatchEffectSelection)
	CCWatchOptionsEffectDurationStatic:SetText(CCWATCH.CCS[CCWatchEffectSelection].DURATION)

	if CCWATCH.CCS[CCWatchEffectSelection].ETYPE == ETYPE_BUFF then
		CCWatchOptionsEffectType:SetText"BUFF"
	elseif CCWATCH.CCS[CCWatchEffectSelection].ETYPE == ETYPE_DEBUFF then
		CCWatchOptionsEffectType:SetText"DEBUFF"
	else
		CCWatchOptionsEffectType:SetText"CC"
	end

	CCWatchOptionsBarColorEffect:Enable()
	if CCWATCH.CCS[CCWatchEffectSelection].COLOR ~= nil then
		SetButtonPickerColor("CCWatchOptionsBarColorEffect", CCWATCH.CCS[CCWatchEffectSelection].COLOR)
	else
		SetButtonPickerColor("CCWatchOptionsBarColorEffect", { r=1, g=1, b=1 })
	end

	CCWatchOptionsEffectMonitor:SetChecked(CCWATCH.CCS[CCWatchEffectSelection].MONITOR)
	CCWatchOptionsEffectMonitor:Enable()

	local bFlag = CCWATCH.CCS[CCWatchEffectSelection].WARN > 0
	CCWatchOptionsEffectWarn:SetChecked(bFlag)
	CCWatchOptionsEffectWarn:Enable()
end

function CCWatchOptions_OnLoad()
	UIPanelWindows.CCWatchOptionsFrame = { area='center', pushable=1 }
end

--------------------------------------------------------------------------------
-- Init
--------------------------------------------------------------------------------
function CCWatchOptions_Init()
	CCWatchSliderAlpha:SetValue(CCWATCH.ALPHA)
	CCWatchSliderScale:SetValue(CCWATCH.SCALE)
	CCWatchSliderWidth:SetValue(CCWATCH.WIDTH)

	CCWatchOptionsFrameMonitorCC:SetChecked(bit.band(CCWATCH.MONITORING, ETYPE_CC))
	CCWatchOptionsFrameMonitorDebuff:SetChecked(bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF))
	CCWatchOptionsFrameMonitorBuff:SetChecked(bit.band(CCWATCH.MONITORING, ETYPE_BUFF))

	CCWatchOptionsFrameUnlock:SetChecked(CCWATCH.STATUS == 2)
	CCWatchOptionsFrameInvert:SetChecked(CCWATCH.INVERT)
	CCWatchOptionsFrameArcanist:SetChecked(CCWATCH.ARCANIST)
	CCWatchOptionsWarnCCDropDownText:SetText(CCWATCH.WARNTYPE)
	CCWatchOptionsFrameCustomCCEdit:SetText(CCWATCH.WARNCUSTOMCC)
	if CCWATCH.WARNTYPE == "CHANNEL" then
		CCWatchOptionsFrameCustomCCEdit:Show()
	else
		CCWatchOptionsFrameCustomCCEdit:Hide()
	end

	CCWatchOptionsBarColorEffect:Disable()
	CCWatchOptionsEffectMonitor:Disable()
	CCWatchOptionsEffectWarn:Disable()

	if CCWATCH.GROWTH == 1 then
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_UP)
	else
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_DOWN)
	end

	if CCWATCH.STYLE == 1 then
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_RECENT)
	else
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_ALL)
	end

	UpdateSortTable()
	CCWatchOptionsEffects_Update()

	CCWatchOptionsBarColorEffect.swatchFunc = CCWatchConfig_SwatchFunc_SetColor.Effect
	CCWatchOptionsBarColorEffect.cancelFunc = CCWatchConfig_SwatchFunc_CancelColor.Effect

	CCWatchOptionsFrameWarnApplied:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_APPLIED))
	CCWatchOptionsFrameWarnFaded:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_FADED))
	CCWatchOptionsFrameWarnBroken:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_BROKEN))
	CCWatchOptionsFrameWarnLowTime:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_LOWTIME))

	CCWatchOptionsBarsFrame:Show()
	CCWatchOptionsEffectsTabTexture:Hide()
	CCWatchOptionsEffectsTab:SetBackdropBorderColor(.25, .25, .25, 1)
	CCWatchOptionsLearnTabTexture:Hide()
	CCWatchOptionsLearnTab:SetBackdropBorderColor(.25, .25, .25, 1)
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

	local itemSlot = getglobal("CCWatchOptionsEffectsItem" .. (item - curoffset + 1))
	if v == CCWatchEffectSelection then
		itemSlot:SetTextColor(1, 1, 0)
	else
		itemSlot:SetTextColor(1, 1, 1)
	end
	itemSlot:SetText(v)
	itemSlot:Show()
end

function CCWatchOptionsEffects_Update()
	CCcount = 0

	CCcount = getn(DisplayTable)

	FauxScrollFrame_Update(CCWatchOptionsEffectsListScrollFrame, CCcount, 11, 16)

	item = -1
	curoffset = FauxScrollFrame_GetOffset(CCWatchOptionsEffectsListScrollFrame)

	table.foreach(DisplayTable, EffectsUpdate)
end

-- Tooltip Window

function CCWatchOptionsEffects_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT")

	local spellname = this:GetText()
	if spellname == nil then
		return
	end

	if CCWATCH.CCS[spellname] == nil then
		CCWatch_AddMessage("Error : '" .. spellname .. "' not found in effect array.")
		return
	end
	local str = spellname .. "\nDuration: " .. CCWATCH.CCS[spellname].DURATION .. "\nType: "
	if CCWATCH.CCS[spellname].ETYPE == ETYPE_BUFF then
		str = str .. "Buff"
	elseif CCWATCH.CCS[spellname].ETYPE == ETYPE_DEBUFF then
		str = str .. "DeBuff"
	else
		str = str .. "CC"
	end
	str = str .. "\nMonitor: "
	if CCWATCH.CCS[spellname].MONITOR then
		str = str .. "on"
	else
		str = str .. "off"
	end
	str = str .. "\nWarn: "
	if CCWATCH.CCS[spellname].WARN > 0 then
		str = str .. "on"
	else
		str = str .. "off"
	end

	GameTooltip:SetText(str, 1, 1, 1)
end

-- Confirm dialog frame

function CCWatch_OpenDiagToggle()
	if (CCWatch_DiagOpen) then
		CCWatch_DiagOpen = false
	else
		CCWatch_DiagOpen = true
	end
end

