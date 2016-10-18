CCWatchLoaded = false

CCWatchObject = nil

CCWATCH_MAXBARS = 10

CCWATCH_SCHOOL = {
	NONE = {1, 1, 1},
	PHYSICAL = {1, 1, 0},
	HOLY = {1, .9, .5},
	FIRE = {1, .5, 0},
	NATURE = {.3, 1, .3},
	FROST = {.5, 1, 1},
	SHADOW = {.5, .5, 1},
	ARCANE = {1, .5, 1},
}

do
	local DR_CLASS = {
		["Bash"] = 1,
		["Hammer of Justice"] = 1,
		["Cheap Shot"] = 1,
		["Charge Stun"] = 1,
		["Intercept Stun"] = 1,
		["Concussion Blow"] = 1,

		["Fear"] = 2,
		["Howl of Terror"] = 2,
		["Seduction"] = 2,
		["Intimidating Shout"] = 2,
		["Psychic Scream"] = 2,

		["Polymorph"] = 3,
		["Sap"] = 3,
		["Gouge"] = 3,

		["Entangling Roots"] = 4,
		["Frost Nova"] = 4,

		["Freezing Trap"] = 5,
		["Wyvern String"] = 5,

		["Blind"] = 6,

		["Hibernate"] = 7,

		["Mind Control"] = 8,

		["Kidney Shot"] = 9,

		["Death Coil"] = 10,

		["Frost Shock"] = 11,
	}

	local dr = {}

	local function diminish(key, seconds)
		return 1 / 2^(dr[key].level - 1) * seconds
	end

	function CCWatch_DiminishedDuration(unit, effect, full_duration)
		local class = DR_CLASS[effect]
		if class then
			local key = unit .. '|' .. class
			if not dr[key] or dr[key].timeout < GetTime() then
				dr[key] = {level=1, timeout=GetTime() + full_duration + 15}
			elseif dr[key].level < 3 then
				dr[key].level = dr[key].level + 1
				dr[key].timeout = GetTime() + diminish(key, full_duration) + 15
			else
				return 0
			end
			return diminish(key, full_duration)
		else
			return full_duration
		end
	end
end

do
	local tt = CreateFrame('GameTooltip', 'aurae_tooltip', nil, 'GameTooltipTemplate')
	function aurae_UnitDebuffs(unit)
		local debuffs = {}
		local i = 1
		while UnitDebuff(unit, i) do
			aurae_tooltip:SetOwner(UIParent)
			aurae_tooltip:SetUnitDebuff(unit, i)
			debuffs[aurae_tooltipTextLeft1:GetText()] = true
			i = i + 1
		end
		return debuffs
	end
end

local bars = {}

local function create_bar(name)
	local bar = {}
	bars[name] = bar

	local color = bar.color or {1, 0, 1}
	local bgcolor = {0, .5, .5, .5}
	local icon = bar.icon or nil
	local iconpos = 'LEFT'
	local texture = [[Interface\Addons\CCWatch\Textures\BantoBar]]
	local width = 200
	local height = 16
	local point = 'CENTER'
	local rframe = UIParent
	local rpoint = 'CENTER'
	local xoffset = 0
	local yoffset = 0
	local text = bar.text
	local fontsize = 11
	local textcolor = {1, 1, 1}
	local timertextcolor = {1, 1, 1}
	local scale = 1

	local timertextwidth = fontsize * 3.6
	local font, _, style = GameFontHighlight:GetFont()

	bar.fadetime = .5
	bar.width = 200
	bar.bgcolor = bgcolor
	bar.textcolor = textcolor
	bar.timertextcolor = timertextcolor

	local f = CreateFrame('Button', nil, UIParent)

	f.owner = name

	f:SetWidth(width + height)
	f:SetHeight(height)
	f:ClearAllPoints()
	f:SetPoint(point, rframe, rpoint, xoffset, yoffset)

	f:EnableMouse(false)
	f:RegisterForClicks()
	f:SetScript('OnClick', nil)
	f:SetScale(scale)

	f.icon = CreateFrame('Button', nil, f)
	f.icon:ClearAllPoints()
	f.icon.owner = name
	f.icon:EnableMouse(false)
	f.icon:RegisterForClicks()
	f.icon:SetScript('OnClick', nil)
	f.icon:SetHeight(height)
	f.icon:SetWidth(height)
	f.icon:SetPoint('LEFT', f, iconpos, 0, 0)
	f.icon:SetNormalTexture[[Interface\Icons\INV_Misc_QuestionMark]]
	f.icon:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)
	f.icon:Show()

	f.statusbar = CreateFrame('StatusBar', nil, f)
	f.statusbar:ClearAllPoints()
	f.statusbar:SetHeight(height)
	f.statusbar:SetWidth(width)
	f.statusbar:SetPoint('TOPLEFT', f, 'TOPLEFT', height, 0)
	f.statusbar:SetStatusBarTexture(texture)
	f.statusbar:SetStatusBarColor(color[1], color[2], color[3], color[4])
	f.statusbar:SetMinMaxValues(0, 1)
	f.statusbar:SetValue(1)
	f.statusbar:SetBackdrop{ bgFile=texture }
	f.statusbar:SetBackdropColor(bgcolor[1], bgcolor[2], bgcolor[3], bgcolor[4])

	f.spark = f.statusbar:CreateTexture(nil, 'OVERLAY')
	f.spark:SetTexture[[Interface\CastingBar\UI-CastingBar-Spark]]
	f.spark:SetWidth(16)
	f.spark:SetHeight(height + 25)
	f.spark:SetBlendMode'ADD'
	f.spark:Show()

	f.timertext = f.statusbar:CreateFontString(nil, 'OVERLAY')
	f.timertext:SetFontObject(GameFontHighlight)
	f.timertext:SetFont(font, fontsize, style)
	f.timertext:SetHeight(height)
	f.timertext:SetWidth(timertextwidth)
	f.timertext:SetPoint('LEFT', f.statusbar, 'LEFT', 0, 0)
	f.timertext:SetJustifyH'RIGHT'
	f.timertext:SetText''
	f.timertext:SetTextColor(timertextcolor[1], timertextcolor[2], timertextcolor[3], timertextcolor[4])

	f.text = f.statusbar:CreateFontString(nil, 'OVERLAY')
	f.text:SetFontObject(GameFontHighlight)
	f.text:SetFont(font, fontsize, style)
	f.text:SetHeight(height)
	f.text:SetWidth((width - timertextwidth) * .9)
	f.text:SetPoint('RIGHT', f.statusbar, 'RIGHT', 0, 0)
	f.text:SetJustifyH'LEFT'
	f.text:SetText(text)
	f.text:SetTextColor(textcolor[1], textcolor[2], textcolor[3], textcolor[4])

	if bar.onclick then
		f:EnableMouse(true)
		f:RegisterForClicks('LeftButtonUp', 'RightButtonUp', 'MiddleButtonUp', 'Button4Up', 'Button5Up')
		f:SetScript('OnClick', function()
			CandyBar:OnClick()
		end)
		f.icon:EnableMouse(true)
		f.icon:RegisterForClicks('LeftButtonUp', 'RightButtonUp', 'MiddleButtonUp', 'Button4Up', 'Button5Up')
		f.icon:SetScript('OnClick', function()
			CandyBar:OnClick()
		end)
	end

	bar.frame = f	
	return bar
end

local function fade_bar(bar)
	if bar.fadeelapsed > bar.fadetime then
		bar.frame:SetAlpha(0)
	else
		local t = bar.fadetime - bar.fadeelapsed
		local a = t / bar.fadetime
		bar.frame:SetAlpha(a)
	end
end

local function format_time(t)
	local h = floor(t / 3600)
	local m = floor((t - h * 3600) / 60)
	local s = t - (h * 3600 + m * 60)
	if h > 0 then
		return format('%d:%02d', h, m)
	elseif m > 0 then
		return format('%d:%02d', m, floor(s))
	elseif s < 10 then
		return format('%1.1f', s)
	else
		return format('%.0f', floor(s))
	end
end

--	if CCWatch_Save[CCWATCH.PROFILE].WarnSelf then
--		local info = ChatTypeInfo.RAID_WARNING
--		RaidWarningFrame:AddMessage(msg, info.r, info.g, info.b, 1)
--		PlaySound'RaidWarning'
--	end

function CCWatch_Config()
	CCWATCH.EFFECTS = {}

	CCWatch_ConfigCC()
	CCWatch_ConfigDebuff()
	CCWatch_ConfigBuff()
end

function CCWatch_OnLoad()
	CCWatch_Globals()

	local dummy_timer = { stopped=0 }
	for k, type in {'CC', 'Buff', 'Debuff'} do
		for i = 1, CCWATCH_MAXBARS do
			local name = 'CCWatchBar' .. type .. i
			local bar = create_bar(name)
			bar.frame:SetParent(getglobal('CCWatch' .. type))
			bar.frame:SetPoint('TOPLEFT', 0, -100 + i * 20)
			setglobal(name, bar.frame)
			bar.TIMER = dummy_timer
			tinsert(CCWATCH['GROUPS' .. strupper(type)], bar)
		end
	end

	CCWatch_Config()

	CCWatchObject = this

	this:RegisterEvent'UNIT_COMBAT'

 	this:RegisterEvent'CHAT_MSG_COMBAT_HONOR_GAIN'
	this:RegisterEvent'CHAT_MSG_COMBAT_HOSTILE_DEATH'
	this:RegisterEvent'PLAYER_REGEN_ENABLED'

	this:RegisterEvent'CHAT_MSG_SPELL_AURA_GONE_OTHER'
	this:RegisterEvent'CHAT_MSG_SPELL_BREAK_AURA'

	this:RegisterEvent'SPELLCAST_STOP'
	this:RegisterEvent'SPELLCAST_INTERRUPTED'
	this:RegisterEvent'CHAT_MSG_SPELL_SELF_DAMAGE'
	this:RegisterEvent'CHAT_MSG_SPELL_FAILED_LOCALPLAYER'

	this:RegisterEvent'PLAYER_TARGET_CHANGED'
	this:RegisterEvent'UPDATE_MOUSEOVER_UNIT'
	this:RegisterEvent'UPDATE_BATTLEFIELD_SCORE'

	SLASH_CCWATCH1 = "/ccwatch"
	SLASH_CCWATCH2 = "/ccw"
	SlashCmdList.CCWATCH = CCWatch_SlashCommandHandler

	CCWatch_AddMessage(CCWATCH_FULLVERSION .. CCWATCH_LOADED)
end

function CCWatch_BarUnlock()
	CCWATCH.STATUS = 2
	for _, type in {'CC', 'Buff', 'Debuff'} do
		getglobal('CCWatch' .. type):EnableMouse(1)
		for i = 1, CCWATCH_MAXBARS do
			local f = getglobal('CCWatchBar' .. type .. i)
			f:SetAlpha(CCWATCH.ALPHA)
			f.statusbar:SetStatusBarColor(1, 1, 1)
			f.statusbar:SetValue(1)
			f.icon:SetNormalTexture[[Interface\Icons\INV_Misc_QuestionMark]]
			f.text:SetText('CCWatch ' .. type .. ' Bar ' .. i)
			f.timertext:SetText''
			f.spark:Hide()
			-- getglobal(barname.."StatusBarSpark"):SetPoint("CENTER", barname.."StatusBar", "LEFT", 0, 0)
		end
	end
end

function CCWatch_BarLock()
	CCWATCH.STATUS = 1
	CCWatchCC:EnableMouse(0)
	CCWatchDebuff:EnableMouse(0)
	CCWatchBuff:EnableMouse(0)

	for i = 1, CCWATCH_MAXBARS do
		getglobal("CCWatchBarCC" .. i):SetAlpha(0)
		getglobal("CCWatchBarDebuff" .. i):SetAlpha(0)
		getglobal("CCWatchBarBuff" .. i):SetAlpha(0)
	end
end

function CCWatch_SlashCommandHandler(msg)
	if msg then
		local command = strlower(msg)
		if command == "on" then
			if CCWATCH.STATUS == 0 then
				CCWATCH.STATUS = 1
				CCWatch_Save[CCWATCH.PROFILE].status = CCWATCH.STATUS
				CCWatch_AddMessage(CCWATCH_ENABLED)
			end
		elseif command == "off" then
			if CCWATCH.STATUS ~= 0 then
				CCWATCH.STATUS = 0
				CCWatch_Save[CCWATCH.PROFILE].status = CCWATCH.STATUS
				CCWatch_AddMessage(CCWATCH_DISABLED)
			end
		elseif command == "unlock" then
			CCWatch_BarUnlock()
			CCWatch_AddMessage(CCWATCH_UNLOCKED)
			CCWatchOptionsFrameUnlock:SetChecked(true)
		elseif command == "lock" then
			CCWatch_BarLock()
			CCWatch_AddMessage(CCWATCH_LOCKED)
			CCWatchOptionsFrameUnlock:SetChecked(false)
		elseif command == "invert" then
			CCWATCH.INVERT = not CCWATCH.INVERT
			CCWatch_Save[CCWATCH.PROFILE].invert = CCWATCH.INVERT
			if CCWATCH.INVERT then
				CCWatch_AddMessage(CCWATCH_INVERSION_ON)
			else
				CCWatch_AddMessage(CCWATCH_INVERSION_OFF)
			end
			CCWatchOptionsFrameInvert:SetChecked(CCWATCH.INVERT)
		elseif command == "grow up" then
			CCWatch_Save[CCWATCH.PROFILE].growth = 1
			CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth
			CCWatch_AddMessage(CCWATCH_GROW_UP)
			CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_UP)
		elseif command == "grow down" then
			CCWatch_Save[CCWATCH.PROFILE].growth = 2
			CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth
			CCWatch_AddMessage(CCWATCH_GROW_DOWN)
			CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_DOWN)
		elseif command == "color school" then
			CCWatch_Save[CCWATCH.PROFILE].color = CTYPE_SCHOOL
			CCWatch_AddMessage'School color enabled.'
		elseif command == "color progress" then
			CCWatch_Save[CCWATCH.PROFILE].color = CTYPE_PROGRESS
			CCWatch_AddMessage'Progress color enabled.'
		elseif command == "color custom" then
			CCWatch_Save[CCWATCH.PROFILE].color = CTYPE_CUSTOM
			CCWatch_AddMessage'Custom color enabled.'
		elseif command == "clear" then
			CCWatch_Save[CCWATCH.PROFILE] = nil
			CCWatch_Globals()
			CCWatch_Config()
			CCWatch_LoadVariables()
		elseif command == "u" then
			CCWatch_Config()
			CCWatch_LoadConfCCs()
			CCWatch_UpdateClassSpells(true)
		elseif command == "config" then
			CCWatchOptionsFrame:Show()
		elseif strsub(command, 1, 5) == "scale" then
			local scale = tonumber(strsub(command, 7))
			if scale <= 3 and scale >= .25 then
				CCWatch_Save[CCWATCH.PROFILE].scale = scale
				CCWATCH.SCALE = scale
				CCWatchCC:SetScale(CCWATCH.SCALE)
				CCWatchDebuff:SetScale(CCWATCH.SCALE)
				CCWatchBuff:SetScale(CCWATCH.SCALE)
				CCWatch_AddMessage(CCWATCH_SCALE .. scale)
				CCWatchSliderScale:SetValue(CCWATCH.SCALE)
			else
				CCWatch_Help()
			end
		elseif strsub(command, 1, 5) == "width" then
			local width = tonumber(strsub(command, 7))
			if width <= 300 and width >= 50 then
				CCWatch_Save[CCWATCH.PROFILE].width = width
				CCWATCH.WIDTH = width
				CCWatch_SetWidth(CCWATCH.WIDTH)
				CCWatch_AddMessage(CCWATCH_WIDTH .. width)
				CCWatchSliderWidth:SetValue(CCWATCH.WIDTH)
			else
				CCWatch_Help()
			end
		elseif strsub(command, 1, 5) == "alpha" then
			local alpha = tonumber(strsub(command, 7))
			if alpha <= 1 and alpha >= 0 then
				CCWatch_Save[CCWATCH.PROFILE].alpha = alpha
				CCWATCH.ALPHA = alpha
				CCWatch_AddMessage(CCWATCH_ALPHA..alpha)
				CCWatchSliderAlpha:SetValue(CCWATCH.ALPHA)
			else
				CCWatch_Help()
			end
		elseif command == "print" then
			CCWatch_AddMessage(CCWATCH_PROFILE_TEXT..CCWATCH.PROFILE);
			if CCWATCH.STATUS == 0 then
				CCWatch_AddMessage(CCWATCH_DISABLED)
			elseif CCWATCH.STATUS == 2 then
				CCWatch_AddMessage(CCWATCH_UNLOCKED)
			else
				CCWatch_AddMessage(CCWATCH_ENABLED)
			end
			if CCWATCH.INVERT then
				CCWatch_AddMessage(CCWATCH_INVERSION_ON)
			else
				CCWatch_AddMessage(CCWATCH_INVERSION_OFF)
			end
			if CCWATCH.GROWTH == 1 then
				CCWatch_AddMessage(CCWATCH_GROW_UP)
			else
				CCWatch_AddMessage(CCWATCH_GROW_DOWN)
			end
			CCWatch_Config()
			CCWatch_LoadConfCCs()
			CCWatch_UpdateClassSpells(true)

			CCWatch_AddMessage(CCWATCH_SCALE..CCWATCH.SCALE)
			CCWatch_AddMessage(CCWATCH_WIDTH..CCWATCH.WIDTH)
			CCWatch_AddMessage(CCWATCH_ALPHA..CCWATCH.ALPHA)
		else
			CCWatch_Help()
		end
	end
end

function CCWatch_OnEvent(event)
	if CCWATCH.STATUS == 0 then
		return
	end
	CCWatch_EventHandler[event]()
end

CCWatch_EventHandler = {}

do
	local function target_sex()
		local code = UnitSex'target'
		if code == 2 then
			return 'M'
		elseif code == 3 then
			return 'F'
		else
			return ''
		end
	end

	function CCWatch_TargetID()
		local name = UnitName'target'
		if name then
			return UnitIsPlayer'target' and name or '[' .. (UnitRace'target' and  UnitRace'target' .. ' ' or '') .. UnitLevel'target' .. target_sex() .. '] ' .. name
		end
	end
end

do
	local casting = {}
	local last_cast
	local pending = {}

	do
		CreateFrame('GameTooltip', 'CCWatch_Tooltip', nil, 'GameTooltipTemplate')
		local orig = UseAction
		function UseAction(slot, clicked, onself)
			if HasAction(slot) and not GetActionText(slot) and not onself then
				CCWatch_Tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
				CCWatch_Tooltip:SetAction(slot)
				casting[CCWatch_TooltipTextLeft1:GetText()] = CCWatch_TargetID()
			end
			return orig(slot, clicked, onself)
		end
	end

	do
		local orig = CastSpell
		function CastSpell(index, booktype)
			casting[GetSpellName(index, booktype)] = CCWatch_TargetID()
			return orig(index, booktype)
		end
	end

	do
		local orig = CastSpellByName
		function CastSpellByName(text, onself)
			if not onself then
				casting[text] = CCWatch_TargetID()
			end
			return orig(text, onself)
		end
	end

	function CCWatch_EventHandler.CHAT_MSG_SPELL_FAILED_LOCALPLAYER()
		for effect in string.gfind(arg1, 'You fail to %a+ (.*):.*') do
			casting[effect] = nil
		end
	end

	function CCWatch_EventHandler.SPELLCAST_STOP()
		for effect, target in casting do
			if (CCWatch_EffectActive(effect, target) or not CCWatch_IsPlayer(target) and CCWATCH.EFFECTS[effect]) and CCWATCH.EFFECTS[effect].ETYPE ~= ETYPE_BUFF then
				if pending[effect] then
					last_cast = nil
				else
					pending[effect] = {target=target, time=GetTime() + .5}
					last_cast = effect
				end
			end
		end
		casting = {}
	end

	CreateFrame'Frame':SetScript('OnUpdate', function()
		for effect, info in pending do
			if GetTime() >= info.time then
				CCWatch_StartTimer(effect, info.target, GetTime() - .5)
				pending[effect] = nil
			end
		end
	end)

	function CCWatch_AbortCast(effect, unit)
		for k, v in pending do
			if k == effect and v.target == unit then
				pending[k] = nil
			end
		end
	end

	function CCWatch_AbortUnitCasts(unit)
		for k, v in pending do
			if v.target == unit or not unit and not CCWatch_IsPlayer(v.target) then
				pending[k] = nil
			end
		end
	end

	function CCWatch_EventHandler.SPELLCAST_INTERRUPTED()
		if last_cast then
			pending[last_cast] = nil
		end
	end

	do
		local patterns = {
			'is immune to your (.*)%.',
			'Your (.*) missed',
			'Your (.*) was resisted',
			'Your (.*) was evaded',
			'Your (.*) was dodged',
			'Your (.*) was deflected',
			'Your (.*) is reflected',
			'Your (.*) is parried'
		}
		function CCWatch_EventHandler.CHAT_MSG_SPELL_SELF_DAMAGE()
			for _, pattern in patterns do
				local _, _, effect = strfind(arg1, pattern)
				if effect then
					pending[effect] = nil
					return
				end
			end
		end
	end
end

function CCWatch_EventHandler.CHAT_MSG_SPELL_AURA_GONE_OTHER()
	for effect, unit in string.gfind(arg1, CCWATCH_TEXT_OFF) do
		if CCWATCH.EFFECTS[effect] then
			if CCWatch_IsPlayer(unit) then
				CCWatch_AbortCast(effect, unit)
				CCWatch_StopTimer(effect, unit)
			elseif unit == UnitName'target' then
				-- TODO pet target (in other places too)
				local unit = CCWatch_TargetID()
				local debuffs = aurae_UnitDebuffs'target'
				for k, timer in aurae_timers do
					if timer.UNIT == unit and not debuffs[timer.EFFECT] then
						-- TODO only if "appreciated" (weird doTimer terminology)
						CCWatch_StopTimer(timer.EFFECT, timer.UNIT)
					end
				end
			end
		end
	end
end

function CCWatch_EventHandler.CHAT_MSG_SPELL_BREAK_AURA()
	for unit, effect in string.gfind(arg1, CCWATCH_TEXT_BREAK) do
		if CCWATCH.EFFECTS[effect] and CCWatch_IsPlayer(unit) then
			CCWatch_AbortCast(effect, unit)
			CCWatch_StopTimer(effect, unit)
		end
	end
end

--function DoTimer_ChangedTargets()
--	local newtarget
--	if UnitName("target") then newtarget = {UnitName("target"),UnitSex("target"),UnitLevel("target")} end
--
--	for i = 1,table.getn(casted) do casted[i].eligible = 1 end --all tables are now eligible for depreciated timers
--	local found = DoTimer_ReturnTargetTable(lasttarget[1],lasttarget[2],lasttarget[3])
--	if newtarget and newtarget[1] == lasttarget[1] and newtarget[2] == lasttarget[2] and newtarget[3] == lasttarget[3] then
--		DoTimer_Debug("new target identical to old target")
--		if found then
--			DoTimer_Debug("depreciating all appreciated timers for "..casted[found].target)
--			for i = table.getn(casted[found]),1,-1 do
--				if DoTimer_TimerIsAppreciated(found,i) then DoTimer_DepreciateTimer(found,i) end --if we are switching targets to one that is "identical" to the previous, automatically depreciate since we know they are inaccurate
--			end
--		end
--	end
--	if UnitName("target") then lasttarget = {UnitName("target"),UnitSex("target"),UnitLevel("target")} else lasttarget = {} end
--end

function CCWatch_EventHandler.CHAT_MSG_COMBAT_HOSTILE_DEATH()
	for unit in string.gfind(arg1, CCWATCH_TEXT_DIE) do
		if CCWatch_IsPlayer(unit) then
			CCWatch_UNIT_DEATH(unit)
		elseif unit == UnitName'target' and UnitIsDead'target' then
			-- TODO only if "appreciated" (weird doTimer terminology)
			CCWatch_UNIT_DEATH(CCWatch_TargetID())
		end
	end
end

function CCWatch_EventHandler.CHAT_MSG_COMBAT_HONOR_GAIN()
	for unit in string.gfind(arg1, '(.+) dies') do
		CCWatch_UNIT_DEATH(unit)
	end
end

function CCWatch_EventHandler.UNIT_COMBAT()
	if GetComboPoints() > 0 then
		CCWATCH.COMBO = GetComboPoints()
	end
end

do
	aurae_timers = {}

	local function place_timers()
			for _, timer in aurae_timers do
			if timer.shown and not timer.visible then
				local group
				if CCWATCH.EFFECTS[timer.EFFECT].ETYPE == ETYPE_BUFF then
					group = CCWATCH.GROUPSBUFF
				elseif CCWATCH.EFFECTS[timer.EFFECT].ETYPE == ETYPE_DEBUFF then
					group = CCWATCH.GROUPSDEBUFF
				else
					group = CCWATCH.GROUPSCC
				end
				if CCWATCH.GROWTH == 1 then
					for i = 1, CCWATCH_MAXBARS do
						if group[i].TIMER.stopped then
							group[i].TIMER = timer
							timer.visible = true
							break
						end
					end
				else
					for i = CCWATCH_MAXBARS, 1, -1 do
						if group[i].TIMER.stopped then
							group[i].TIMER = timer
							timer.visible = true
							break
						end
					end
				end
			end
		end
	end

	function CCWatch_UpdateTimers()
		local t = GetTime()
		for _, timer in aurae_timers do
			if t > timer.END then
				CCWatch_StopTimer(timer.EFFECT, timer.UNIT)
				if CCWatch_IsPlayer(timer.UNIT) then
					CCWatch_AbortCast(timer.EFFECT, timer.UNIT)
				end
			end
		end
	end

	function CCWatch_EffectActive(effect, unit)
		return aurae_timers[effect .. '@' .. unit] and true or false
	end

	function CCWatch_StartTimer(effect, unit, start)
		local timer = {
			EFFECT = effect,
			UNIT = unit,
			START = start,
			shown = CCWatch_IsShown(unit),
		}

		timer.END = timer.START

		if CCWatch_IsPlayer(unit) then
			timer.END = timer.END + CCWatch_DiminishedDuration(unit, effect, CCWATCH.EFFECTS[effect].PVP_DURATION or CCWATCH.EFFECTS[effect].DURATION)
		else
			timer.END = timer.END + CCWATCH.EFFECTS[effect].DURATION
		end

		if CCWATCH.EFFECTS[effect].COMBO then
			timer.END = timer.END + CCWATCH.EFFECTS[effect].A * CCWATCH.COMBO
		end

		local old_timer = aurae_timers[effect .. '@' .. unit]
		if old_timer and not old_timer.stopped then
			old_timer.START = timer.START
			old_timer.END = timer.END
			old_timer.shown = old_timer.shown or timer.shown
		else
			aurae_timers[effect .. '@' .. unit] = timer
			place_timers()
		end
	end

	function CCWatch_EventHandler.PLAYER_REGEN_ENABLED()
		CCWatch_AbortUnitCasts()
		for k, timer in aurae_timers do
			if not CCWatch_IsPlayer(timer.UNIT) then
				CCWatch_StopTimer(timer.EFFECT, timer.UNIT)
			end
		end
	end

	function CCWatch_StopTimer(effect, unit)
		local key = effect .. '@' .. unit
		if aurae_timers[key] then
			aurae_timers[key].stopped = GetTime()
			aurae_timers[key] = nil
			place_timers()
		end
	end

	function CCWatch_UNIT_DEATH(unit)
		if CCWatch_IsPlayer(unit) then
			CCWatch_AbortUnitCasts(unit)
		end
		for k, timer in aurae_timers do
			if timer.UNIT == unit then
				CCWatch_StopTimer(timer.EFFECT, unit)
			end
		end
		place_timers()
	end

	do
		local f = CreateFrame'Frame'
		local player, current, recent = {}, {}, {}

		local function hostile_player(msg)
			local _, _, name = strfind(arg1, "^([^%s']*)")
			return name
		end

		local function add_recent(unit)
			local t = GetTime()

			recent[unit] = t

			for k, v in recent do
				if t - v > 30 then
					recent[k] = nil
				end
			end

			for _, timer in aurae_timers do
				if timer.UNIT == unit then
					timer.shown = true
				end
			end
			place_timers()
		end

		local function unit_changed(unitID)
			if not UnitCanAttack('player', unitID) then
				return
			end

			local unit = UnitName(unitID)

			player[unit] = UnitIsPlayer(unitID)

			if player[unit] then
				add_recent(unit)
			end
			if player[current[unitID]] and current[unitID] then
				add_recent(current[unitID])
			end
			current[unitID] = unit
		end

		for _, event in {
			'CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS',
			'CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES',
			'CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE',
			'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE',
			'CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF',
			'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS',
		} do f:RegisterEvent(event) end

		f:SetScript('OnEvent', function()
			if strfind(arg1, '. You ') or strfind(arg1, ' you') then
				add_recent(hostile_player(arg1)) -- TODO make sure this happens before the other handlers
			end
		end)

		f:SetScript('OnUpdate', function()
			RequestBattlefieldScoreData()
		end)

		function CCWatch_EventHandler.CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS()
			player[hostile_player(arg1)] = true
			for unit, effect in string.gfind(arg1, CCWATCH_TEXT_BUFF_ON) do
				if CCWATCH.EFFECTS[effect] and CCWATCH.EFFECTS[effect].MONITOR and bit.band(CCWATCH.EFFECTS[effect].ETYPE, CCWATCH.MONITORING) ~= 0 then
					CCWatch_StartTimer(effect, unit, GetTime())
				end
			end
		end

		function CCWatch_EventHandler.CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE()
			player[hostile_player(arg1)] = true
			for unit, effect in string.gfind(arg1, CCWATCH_TEXT_ON) do
				if CCWATCH.EFFECTS[effect] and CCWATCH.EFFECTS[effect].MONITOR and bit.band(CCWATCH.EFFECTS[effect].ETYPE, CCWATCH.MONITORING) ~= 0 then
					CCWatch_StartTimer(effect, unit, GetTime())
				end
			end
		end

		function CCWatch_EventHandler.PLAYER_TARGET_CHANGED()
			unit_changed'target'
		end
		
		function CCWatch_EventHandler.UPDATE_MOUSEOVER_UNIT()
			unit_changed'mouseover'
		end

		function CCWatch_EventHandler.UPDATE_BATTLEFIELD_SCORE()
			for i = 1, GetNumBattlefieldScores() do
				player[GetBattlefieldScore(i)] = true
			end
		end

		function CCWatch_IsShown(unit)
			if not player[unit] or CCWATCH.STYLE == 2 then
				return true
			end
			return UnitName'target' == unit or UnitName'mouseover' == unit or recent[unit] and GetTime() - recent[unit] <= 30
		end

		function CCWatch_IsPlayer(unit)
			return player[unit]
		end

		function CCWatch_AddMessage(msg)
			DEFAULT_CHAT_FRAME:AddMessage('<CCWatch> ' .. msg)
		end
	end
end

function CCWatch_OnUpdate()
	if CCWATCH.STATUS == 0 then
		return
	end
	CCWatch_UpdateTimers()
	if CCWATCH.STATUS == 2 then
		return
	end
	CCWatch_UpdateBars()
end

function CCWatch_UpdateBars()
	for _, group in {CCWATCH.GROUPSBUFF, CCWATCH.GROUPSDEBUFF, CCWATCH.GROUPSCC} do
		for _, bar in group do
			CCWatch_UpdateBar(bar)
		end
	end
end

function CCWatch_UpdateBar(bar)
	if CCWATCH.STATUS ~= 1 then
		return
	end

	local frame = bar.frame
	local timer = bar.TIMER

	local t = GetTime()
	if timer.stopped then
		if frame:GetAlpha() > 0 then
			frame.spark:Hide()
			bar.fadeelapsed = GetTime() - timer.stopped
			fade_bar(bar)
		end
	else
		frame:SetAlpha(CCWATCH.ALPHA)

		local duration = timer.END - timer.START
		local remaining = timer.END - t
		local fraction = remaining / duration

		frame.statusbar:SetValue(CCWATCH.INVERT and 1 - fraction or fraction)

		local sparkPosition = bar.width * fraction
		frame.spark:Show()
		frame.spark:SetPoint('CENTER', bar.frame.statusbar, CCWATCH.INVERT and 'RIGHT' or 'LEFT', CCWATCH.INVERT and -sparkPosition or sparkPosition, 0)

		frame.timertext:SetText(format_time(remaining))

		local r, g, b
		if CCWatch_Save[CCWATCH.PROFILE].color == CTYPE_SCHOOL then
			r, g, b = unpack(CCWATCH.EFFECTS[timer.EFFECT].SCHOOL or {1, 0, 1})
		elseif CCWatch_Save[CCWATCH.PROFILE].color == CTYPE_PROGRESS then
			r, g, b = 1 - fraction, fraction, 0
		elseif CCWatch_Save[CCWATCH.PROFILE].color == CTYPE_CUSTOM then
			if CCWATCH.EFFECTS[timer.EFFECT].COLOR then
				r, g, b = CCWATCH.EFFECTS[timer.EFFECT].COLOR.r, CCWATCH.EFFECTS[timer.EFFECT].COLOR.g, CCWATCH.EFFECTS[timer.EFFECT].COLOR.b
			else
				r, g, b = 1, 1, 1
			end
		end
		frame.statusbar:SetStatusBarColor(r, g, b)
		frame.statusbar:SetBackdropColor(r, g, b, .3)

		frame.icon:SetNormalTexture([[Interface\Icons\]] .. (CCWATCH.EFFECTS[timer.EFFECT].ICON or 'INV_Misc_QuestionMark'))
		frame.text:SetText(timer.UNIT)
	end
end

local function GetConfCC(k, v)
	if CCWATCH.EFFECTS[k] then
		CCWATCH.EFFECTS[k].MONITOR = v.MONITOR
		CCWATCH.EFFECTS[k].COLOR = v.COLOR
	end
end

function CCWatch_LoadConfCCs()
	table.foreach(CCWatch_Save[CCWATCH.PROFILE].ConfCC, GetConfCC)
end

function CCWatch_LoadVariablesOnUpdate(arg1)
	if not CCWATCH.LOADEDVARIABLES then
		CCWatch_LoadVariables()
		CCWATCH.LOADEDVARIABLES = true
	end
end

function CCWatch_LoadVariables()
	local default_settings = {
		SavedCC = {},
		ConfCC = {},
		status = CCWATCH.STATUS,
		invert = false,
		growth = 1,
		color = CTYPE_SCHOOL,
		scale = 1,
		width = 160,
		alpha = 1,
		arcanist = false,
		style = 1,
		Monitoring = bit.bor(ETYPE_CC, ETYPE_DEBUFF, ETYPE_BUFF),
	}

	CCWATCH.PROFILE = UnitName'player' .. '@' .. GetCVar'RealmName'

	CCWatch_Save[CCWATCH.PROFILE] = CCWatch_Save[CCWATCH.PROFILE] or {}

	for k, v in default_settings do
		if CCWatch_Save[CCWATCH.PROFILE][k] == nil then
			CCWatch_Save[CCWATCH.PROFILE][k] = v
		end
	end

	CCWATCH.ARCANIST = CCWatch_Save[CCWATCH.PROFILE].arcanist

	CCWatch_LoadConfCCs()
	CCWatch_UpdateClassSpells(false)

	CCWATCH.STATUS = CCWatch_Save[CCWATCH.PROFILE].status
	CCWATCH.INVERT = CCWatch_Save[CCWATCH.PROFILE].invert
	CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth
	CCWATCH.SCALE = CCWatch_Save[CCWATCH.PROFILE].scale
	CCWATCH.WIDTH = CCWatch_Save[CCWATCH.PROFILE].width
	CCWATCH.ALPHA = CCWatch_Save[CCWATCH.PROFILE].alpha

	CCWATCH.MONITORING = CCWatch_Save[CCWATCH.PROFILE].Monitoring

	if bit.band(CCWATCH.MONITORING, ETYPE_CC) ~= 0 or bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF) ~= 0 then
		CCWatchObject:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE'
	end
	if bit.band(CCWATCH.MONITORING, ETYPE_BUFF) ~= 0 then
		CCWatchObject:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS'
	end

	CCWATCH.STYLE = CCWatch_Save[CCWATCH.PROFILE].style

	CCWatchCC:SetScale(CCWATCH.SCALE)
	CCWatchDebuff:SetScale(CCWATCH.SCALE)
	CCWatchBuff:SetScale(CCWATCH.SCALE)
	CCWatch_SetWidth(CCWATCH.WIDTH)

	if CCWATCH.STATUS == 2 then
		CCWatch_BarUnlock()
	end

	CCWatchOptions_Init()
	CCWatch_BarLock()
end

function CCWatch_UpdateImpGouge()
	local talentname, texture, _, _, rank = GetTalentInfo(2, 1)
	if texture then
		if rank ~= 0 then
			CCWATCH.EFFECTS[CCWATCH_GOUGE].DURATION = 4 + rank * .5
		end
	elseif CCWATCH.EFFECTS[CCWATCH_GOUGE].DURATION == nil then
		CCWATCH.EFFECTS[CCWATCH_GOUGE].DURATION = 4
	end
end

function CCWatch_UpdateImpGarotte()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 8)
	if texture then
		if rank ~= 0 then
			CCWATCH.EFFECTS[CCWATCH_GAROTTE].DURATION = 18 + rank * 3
		end
	elseif CCWATCH.EFFECTS[CCWATCH_GAROTTE].DURATION == nil then
		CCWATCH.EFFECTS[CCWATCH_GAROTTE].DURATION = 18
	end
end

function CCWatch_UpdateKidneyShot()
	local i = 1
	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)
		if not name then
			if CCWATCH.EFFECTS[CCWATCH_KS].DURATION == nil then
				CCWATCH.EFFECTS[CCWATCH_KS].DURATION = 1
			end
			return
		end

		if name == CCWATCH_KS then
			if strsub(rank,string.len(rank)) == "1" then
				CCWATCH.EFFECTS[CCWATCH_KS].DURATION = 0
			else
				CCWATCH.EFFECTS[CCWATCH_KS].DURATION = 1
			end
			return
		end

		i = i + 1
	end
end

function CCWatch_UpdateImpTrap()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 7)
	if texture then
		if rank ~= 0 then
-- Freezing Trap is a true multi rank, hence already updated
			CCWATCH.EFFECTS[CCWATCH_FREEZINGTRAP].DURATION = CCWATCH.EFFECTS[CCWATCH_FREEZINGTRAP].DURATION * (1 + rank * .15)
		end
	end
end

function CCWatch_UpdateImpSeduce()
	local talentname, texture, _, _, rank = GetTalentInfo(2, 7)
	if texture then
		if rank ~= 0 then
			CCWATCH.EFFECTS[CCWATCH_SEDUCE].DURATION = 15 * (1 + rank * .10)
		end
	end
end

function CCWatch_UpdateBrutalImpact()
	local talentname, texture, _, _, rank = GetTalentInfo(2, 4)
	if texture then
		if rank ~= 0 then
-- Bash is a true multi rank, hence already updated
			CCWATCH.EFFECTS[CCWATCH_POUNCE].DURATION = 2 + rank * .50
			CCWATCH.EFFECTS[CCWATCH_BASH].DURATION = CCWATCH.EFFECTS[CCWATCH_BASH].DURATION + rank * .50
		end
	end
end

function CCWatch_UpdatePermafrost()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 2)
	if texture then
		if rank ~= 0 then
-- Frostbolt is a true multi rank, hence already updated
			CCWATCH.EFFECTS[CCWATCH_CONEOFCOLD].DURATION = 8 + .50 + rank * .50
			CCWATCH.EFFECTS[CCWATCH_FROSTBOLT].DURATION = CCWATCH.EFFECTS[CCWATCH_FROSTBOLT].DURATION + .50 + rank * .50
		end
	end
end

function CCWatch_UpdateImpShadowWordPain()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 4)
	if texture then
		if rank ~= 0 then
			CCWATCH.EFFECTS[CCWATCH_SHADOWWORDPAIN].DURATION = 18 + rank * 3
		end
	end
end

function CCWatch_GetSpellRank(spellname, spelleffect)
	local i = 1
	local gotone = false
	local maxrank = CCWATCH_SPELLS[spellname].RANKS

	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)

		if not name then
			if not gotone then
				if CCWATCH.EFFECTS[spelleffect].DURATION == nil then
					CCWATCH.EFFECTS[spelleffect].DURATION = CCWATCH_SPELLS[spellname].DURATION[maxrank]
				end
			end
			return
		end

		if name == spellname then
			local currank = 1
			while currank <= maxrank do
				if tonumber(strsub(rank,string.len(rank))) == currank then
					CCWATCH.EFFECTS[spelleffect].DURATION = CCWATCH_SPELLS[spellname].DURATION[currank]
					gotone = true
				end
				currank = currank + 1
			end
		end

		i = i + 1
	end
end

function CCWatch_UpdateClassSpells()
	local _, eclass = UnitClass'player'
	CCWatchOptionsFrameArcanist:Hide()
	if eclass == "ROGUE" then
		CCWatch_GetSpellRank(CCWATCH_SAP, CCWATCH_SAP)
		CCWatch_UpdateImpGouge()
		CCWatch_UpdateKidneyShot()
		if CCWatch_ConfigBuff ~= nil then
			CCWatch_UpdateImpGarotte()
		end
	elseif eclass == "WARRIOR" then
		CCWatch_GetSpellRank(CCWATCH_REND, CCWATCH_REND)
	elseif eclass == "WARLOCK" then
		CCWatch_GetSpellRank(CCWATCH_FEAR, CCWATCH_FEAR)
		CCWatch_GetSpellRank(CCWATCH_HOWLOFTERROR, CCWATCH_HOWLOFTERROR)
		CCWatch_GetSpellRank(CCWATCH_BANISH, CCWATCH_BANISH)
		CCWatch_GetSpellRank(CCWATCH_CORRUPTION, CCWATCH_CORRUPTION)
		CCWatch_UpdateImpSeduce()
	elseif eclass == "PALADIN" then
		CCWatch_GetSpellRank(CCWATCH_HOJ, CCWATCH_HOJ)
		if CCWatch_ConfigBuff ~= nil then
			CCWatch_GetSpellRank(CCWATCH_DIVINESHIELD, CCWATCH_DIVINESHIELD)
		end
	elseif eclass == "HUNTER" then
		CCWatch_GetSpellRank(CCWATCH_FREEZINGTRAP_SPELL, CCWATCH_FREEZINGTRAP)
		CCWatch_GetSpellRank(CCWATCH_SCAREBEAST, CCWATCH_SCAREBEAST)
		CCWatch_UpdateImpTrap()
	elseif eclass == "PRIEST" then
		CCWatch_GetSpellRank(CCWATCH_SHACKLE, CCWATCH_SHACKLE)
		if CCWatch_ConfigDebuff ~= nil then
			CCWatch_UpdateImpShadowWordPain()
		end
	elseif eclass == "MAGE" then
		if CCWatch_ConfigDebuff ~= nil then
			CCWatch_GetSpellRank(CCWATCH_POLYMORPH, CCWATCH_POLYMORPH)
			CCWatch_GetSpellRank(CCWATCH_FROSTBOLT, CCWATCH_FROSTBOLT)
			CCWatch_GetSpellRank(CCWATCH_FIREBALL, CCWATCH_FIREBALL)
			CCWatch_UpdatePermafrost()
		end
		CCWatchOptionsFrameArcanist:Show()
		if CCWATCH.ARCANIST then
			CCWATCH.EFFECTS[CCWATCH_POLYMORPH].DURATION = CCWATCH.EFFECTS[CCWATCH_POLYMORPH].DURATION + 15
		end
	elseif eclass == "DRUID" then
		CCWatch_GetSpellRank(CCWATCH_ROOTS, CCWATCH_ROOTS)
		CCWatch_GetSpellRank(CCWATCH_HIBERNATE, CCWATCH_HIBERNATE)
		CCWatch_GetSpellRank(CCWATCH_BASH, CCWATCH_BASH)
		CCWatch_UpdateBrutalImpact()
	end
end

function CCWatch_Help()
	CCWatch_AddMessage(CCWATCH_FULLVERSION .. CCWATCH_HELP1)
	CCWatch_AddMessage(CCWATCH_HELP2)
	CCWatch_AddMessage(CCWATCH_HELP3)
	CCWatch_AddMessage(CCWATCH_HELP4)
	CCWatch_AddMessage(CCWATCH_HELP5)
	CCWatch_AddMessage(CCWATCH_HELP6)
	CCWatch_AddMessage(CCWATCH_HELP7)
	CCWatch_AddMessage(CCWATCH_HELP8)
	CCWatch_AddMessage(CCWATCH_HELP9)
	CCWatch_AddMessage(CCWATCH_HELP10)
	CCWatch_AddMessage(CCWATCH_HELP11)
	CCWatch_AddMessage(CCWATCH_HELP12)
	CCWatch_AddMessage(CCWATCH_HELP13)
	CCWatch_AddMessage(CCWATCH_HELP14)
	CCWatch_AddMessage(CCWATCH_HELP15)
	CCWatch_AddMessage(CCWATCH_HELP16)
	CCWatch_AddMessage(CCWATCH_HELP17)
end

function CCWatch_SetWidth(width)
	for _, k in {'CC', 'Debuff', 'Buff'} do
		for i = 1, CCWATCH_MAXBARS do
			getglobal("CCWatchBar" .. k .. i):SetWidth(width + 10)
		end
		getglobal("CCWatch" .. k):SetWidth(width + 10)
	end
end