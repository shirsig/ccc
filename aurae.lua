auraeLoaded = false

auraeObject = nil

aurae_MAXBARS = 10

aurae_SCHOOL = {
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

	function aurae_DiminishedDuration(unit, effect, full_duration)
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
	CreateFrame('GameTooltip', 'aurae_tooltip', nil, 'GameTooltipTemplate')
	function aurae_UnitDebuffs(unit)
		local debuffs = {}
		local i = 1
		while UnitDebuff(unit, i) do
			aurae_tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
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
	local texture = [[Interface\Addons\aurae\Textures\BantoBar]]
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

--	if aurae_Save[aurae.PROFILE].WarnSelf then
--		local info = ChatTypeInfo.RAID_WARNING
--		RaidWarningFrame:AddMessage(msg, info.r, info.g, info.b, 1)
--		PlaySound'RaidWarning'
--	end

function aurae_Config()
	aurae.EFFECTS = {}

	aurae_ConfigCC()
	aurae_ConfigDebuff()
	aurae_ConfigBuff()
end

function aurae_OnLoad()
	aurae_Globals()

	local dummy_timer = { stopped=0 }
	for k, type in {'CC', 'Buff', 'Debuff'} do
		for i = 1, aurae_MAXBARS do
			local name = 'auraeBar' .. type .. i
			local bar = create_bar(name)
			bar.frame:SetParent(getglobal('aurae' .. type))
			bar.frame:SetPoint('TOPLEFT', 0, -100 + i * 20)
			setglobal(name, bar.frame)
			bar.TIMER = dummy_timer
			tinsert(aurae['GROUPS' .. strupper(type)], bar)
		end
	end

	aurae_Config()

	auraeObject = this

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

	SLASH_aurae1 = "/aurae"
	SlashCmdList.aurae = aurae_SlashCommandHandler

	aurae_AddMessage(aurae_FULLVERSION .. aurae_LOADED)
end

function aurae_BarUnlock()
	aurae.STATUS = 2
	for _, type in {'CC', 'Buff', 'Debuff'} do
		getglobal('aurae' .. type):EnableMouse(1)
		for i = 1, aurae_MAXBARS do
			local f = getglobal('auraeBar' .. type .. i)
			f:SetAlpha(aurae.ALPHA)
			f.statusbar:SetStatusBarColor(1, 1, 1)
			f.statusbar:SetValue(1)
			f.icon:SetNormalTexture[[Interface\Icons\INV_Misc_QuestionMark]]
			f.text:SetText('aurae ' .. type .. ' Bar ' .. i)
			f.timertext:SetText''
			f.spark:Hide()
			-- getglobal(barname.."StatusBarSpark"):SetPoint("CENTER", barname.."StatusBar", "LEFT", 0, 0)
		end
	end
end

function aurae_BarLock()
	aurae.STATUS = 1
	auraeCC:EnableMouse(0)
	auraeDebuff:EnableMouse(0)
	auraeBuff:EnableMouse(0)

	for i = 1, aurae_MAXBARS do
		getglobal("auraeBarCC" .. i):SetAlpha(0)
		getglobal("auraeBarDebuff" .. i):SetAlpha(0)
		getglobal("auraeBarBuff" .. i):SetAlpha(0)
	end
end

function aurae_SlashCommandHandler(msg)
	if msg then
		local command = strlower(msg)
		if command == "on" then
			if aurae.STATUS == 0 then
				aurae.STATUS = 1
				aurae_Save[aurae.PROFILE].status = aurae.STATUS
				aurae_AddMessage(aurae_ENABLED)
			end
		elseif command == "off" then
			if aurae.STATUS ~= 0 then
				aurae.STATUS = 0
				aurae_Save[aurae.PROFILE].status = aurae.STATUS
				aurae_AddMessage(aurae_DISABLED)
			end
		elseif command == "unlock" then
			aurae_BarUnlock()
			aurae_AddMessage(aurae_UNLOCKED)
			auraeOptionsFrameUnlock:SetChecked(true)
		elseif command == "lock" then
			aurae_BarLock()
			aurae_AddMessage(aurae_LOCKED)
			auraeOptionsFrameUnlock:SetChecked(false)
		elseif command == "invert" then
			aurae.INVERT = not aurae.INVERT
			aurae_Save[aurae.PROFILE].invert = aurae.INVERT
			if aurae.INVERT then
				aurae_AddMessage(aurae_INVERSION_ON)
			else
				aurae_AddMessage(aurae_INVERSION_OFF)
			end
			auraeOptionsFrameInvert:SetChecked(aurae.INVERT)
		elseif command == "grow up" then
			aurae_Save[aurae.PROFILE].growth = 1
			aurae.GROWTH = aurae_Save[aurae.PROFILE].growth
			aurae_AddMessage(aurae_GROW_UP)
			auraeGrowthDropDownText:SetText(aurae_OPTION_GROWTH_UP)
		elseif command == "grow down" then
			aurae_Save[aurae.PROFILE].growth = 2
			aurae.GROWTH = aurae_Save[aurae.PROFILE].growth
			aurae_AddMessage(aurae_GROW_DOWN)
			auraeGrowthDropDownText:SetText(aurae_OPTION_GROWTH_DOWN)
		elseif command == "color school" then
			aurae_Save[aurae.PROFILE].color = CTYPE_SCHOOL
			aurae_AddMessage'School color enabled.'
		elseif command == "color progress" then
			aurae_Save[aurae.PROFILE].color = CTYPE_PROGRESS
			aurae_AddMessage'Progress color enabled.'
		elseif command == "color custom" then
			aurae_Save[aurae.PROFILE].color = CTYPE_CUSTOM
			aurae_AddMessage'Custom color enabled.'
		elseif command == "clear" then
			aurae_Save[aurae.PROFILE] = nil
			aurae_Globals()
			aurae_Config()
			aurae_LoadVariables()
		elseif command == "u" then
			aurae_Config()
			aurae_LoadConfCCs()
			aurae_UpdateClassSpells(true)
		elseif command == "config" then
			auraeOptionsFrame:Show()
		elseif strsub(command, 1, 5) == "scale" then
			local scale = tonumber(strsub(command, 7))
			if scale <= 3 and scale >= .25 then
				aurae_Save[aurae.PROFILE].scale = scale
				aurae.SCALE = scale
				auraeCC:SetScale(aurae.SCALE)
				auraeDebuff:SetScale(aurae.SCALE)
				auraeBuff:SetScale(aurae.SCALE)
				aurae_AddMessage(aurae_SCALE .. scale)
				auraeSliderScale:SetValue(aurae.SCALE)
			else
				aurae_Help()
			end
		elseif strsub(command, 1, 5) == "width" then
			local width = tonumber(strsub(command, 7))
			if width <= 300 and width >= 50 then
				aurae_Save[aurae.PROFILE].width = width
				aurae.WIDTH = width
				aurae_SetWidth(aurae.WIDTH)
				aurae_AddMessage(aurae_WIDTH .. width)
				auraeSliderWidth:SetValue(aurae.WIDTH)
			else
				aurae_Help()
			end
		elseif strsub(command, 1, 5) == "alpha" then
			local alpha = tonumber(strsub(command, 7))
			if alpha <= 1 and alpha >= 0 then
				aurae_Save[aurae.PROFILE].alpha = alpha
				aurae.ALPHA = alpha
				aurae_AddMessage(aurae_ALPHA..alpha)
				auraeSliderAlpha:SetValue(aurae.ALPHA)
			else
				aurae_Help()
			end
		elseif command == "print" then
			aurae_AddMessage(aurae_PROFILE_TEXT..aurae.PROFILE);
			if aurae.STATUS == 0 then
				aurae_AddMessage(aurae_DISABLED)
			elseif aurae.STATUS == 2 then
				aurae_AddMessage(aurae_UNLOCKED)
			else
				aurae_AddMessage(aurae_ENABLED)
			end
			if aurae.INVERT then
				aurae_AddMessage(aurae_INVERSION_ON)
			else
				aurae_AddMessage(aurae_INVERSION_OFF)
			end
			if aurae.GROWTH == 1 then
				aurae_AddMessage(aurae_GROW_UP)
			else
				aurae_AddMessage(aurae_GROW_DOWN)
			end
			aurae_Config()
			aurae_LoadConfCCs()
			aurae_UpdateClassSpells(true)

			aurae_AddMessage(aurae_SCALE..aurae.SCALE)
			aurae_AddMessage(aurae_WIDTH..aurae.WIDTH)
			aurae_AddMessage(aurae_ALPHA..aurae.ALPHA)
		else
			aurae_Help()
		end
	end
end

function aurae_OnEvent(event)
	if aurae.STATUS == 0 then
		return
	end
	aurae_EventHandler[event]()
end

aurae_EventHandler = {}

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

	function aurae_TargetID()
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
		CreateFrame('GameTooltip', 'aurae_Tooltip', nil, 'GameTooltipTemplate')
		local orig = UseAction
		function UseAction(slot, clicked, onself)
			if HasAction(slot) and not GetActionText(slot) and not onself then
				aurae_Tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
				aurae_Tooltip:SetAction(slot)
				casting[aurae_TooltipTextLeft1:GetText()] = aurae_TargetID()
			end
			return orig(slot, clicked, onself)
		end
	end

	do
		local orig = CastSpell
		function CastSpell(index, booktype)
			casting[GetSpellName(index, booktype)] = aurae_TargetID()
			return orig(index, booktype)
		end
	end

	do
		local orig = CastSpellByName
		function CastSpellByName(text, onself)
			if not onself then
				casting[text] = aurae_TargetID()
			end
			return orig(text, onself)
		end
	end

	function aurae_EventHandler.CHAT_MSG_SPELL_FAILED_LOCALPLAYER()
		for effect in string.gfind(arg1, 'You fail to %a+ (.*):.*') do
			casting[effect] = nil
		end
	end

	function aurae_EventHandler.SPELLCAST_STOP()
		for effect, target in casting do
			if (aurae_EffectActive(effect, target) or not aurae_IsPlayer(target) and aurae.EFFECTS[effect]) and aurae.EFFECTS[effect].ETYPE ~= ETYPE_BUFF then
				if pending[effect] then
					last_cast = nil
				else
					pending[effect] = {target=target, time=GetTime() + .5 + (aurae_ACTIONS[effect] and aurae_ACTIONS[effect].DELAY or 0)}
					last_cast = effect
				end
			end
		end
		casting = {}
	end

	CreateFrame'Frame':SetScript('OnUpdate', function()
		for effect, info in pending do
			if GetTime() >= info.time and (aurae_IsPlayer(info.target) or aurae_TargetID() ~= info.target or aurae_UnitDebuffs'target'[effect]) then
				aurae_StartTimer(effect, info.target, GetTime() - .5)
				pending[effect] = nil
			end
		end
	end)

	function aurae_AbortCast(effect, unit)
		for k, v in pending do
			if k == effect and v.target == unit then
				pending[k] = nil
			end
		end
	end

	function aurae_AbortUnitCasts(unit)
		for k, v in pending do
			if v.target == unit or not unit and not aurae_IsPlayer(v.target) then
				pending[k] = nil
			end
		end
	end

	function aurae_EventHandler.SPELLCAST_INTERRUPTED()
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
		function aurae_EventHandler.CHAT_MSG_SPELL_SELF_DAMAGE()
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

function aurae_EventHandler.CHAT_MSG_SPELL_AURA_GONE_OTHER()
	for effect, unit in string.gfind(arg1, aurae_TEXT_OFF) do
		aurae_AuraGone(unit, effect)
	end
end

function aurae_EventHandler.CHAT_MSG_SPELL_BREAK_AURA()
	for unit, effect in string.gfind(arg1, aurae_TEXT_BREAK) do
		aurae_AuraGone(unit, effect)
	end
end

function aurae_AuraGone(unit, effect)
	if aurae.EFFECTS[effect] then
		if aurae_IsPlayer(unit) then
			aurae_AbortCast(effect, unit)
			aurae_StopTimer(effect, unit)
		elseif unit == UnitName'target' then
			-- TODO pet target (in other places too)
			local unit = aurae_TargetID()
			local debuffs = aurae_UnitDebuffs'target'
			for k, timer in aurae_timers do
				if timer.UNIT == unit and not debuffs[timer.EFFECT] then
					-- TODO only if not deprecated
					aurae_StopTimer(timer.EFFECT, timer.UNIT)
				end
			end
		end
	end
end

--function DoTimer_ChangedTargets()
--	for k, timer in aurae_timers do
--		timer.deprecated = true
--	end
	-- TODO deal with pending spells
--end

function aurae_EventHandler.CHAT_MSG_COMBAT_HOSTILE_DEATH()
	for unit in string.gfind(arg1, aurae_TEXT_DIE) do
		if aurae_IsPlayer(unit) then
			aurae_UNIT_DEATH(unit)
		elseif unit == UnitName'target' and UnitIsDead'target' then
			-- TODO only if not deprecated
			aurae_UNIT_DEATH(aurae_TargetID())
		end
	end
end

function aurae_EventHandler.CHAT_MSG_COMBAT_HONOR_GAIN()
	for unit in string.gfind(arg1, '(.+) dies') do
		aurae_UNIT_DEATH(unit)
	end
end

function aurae_EventHandler.UNIT_COMBAT()
	if GetComboPoints() > 0 then
		aurae.COMBO = GetComboPoints()
	end
end

do
	aurae_timers = {}

	local function place_timers()
			for _, timer in aurae_timers do
			if timer.shown and not timer.visible then
				local group
				if aurae.EFFECTS[timer.EFFECT].ETYPE == ETYPE_BUFF then
					group = aurae.GROUPSBUFF
				elseif aurae.EFFECTS[timer.EFFECT].ETYPE == ETYPE_DEBUFF then
					group = aurae.GROUPSDEBUFF
				else
					group = aurae.GROUPSCC
				end
				if aurae.GROWTH == 1 then
					for i = 1, aurae_MAXBARS do
						if group[i].TIMER.stopped then
							group[i].TIMER = timer
							timer.visible = true
							break
						end
					end
				else
					for i = aurae_MAXBARS, 1, -1 do
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

	function aurae_UpdateTimers()
		local t = GetTime()
		for _, timer in aurae_timers do
			if t > timer.END then
				aurae_StopTimer(timer.EFFECT, timer.UNIT)
				if aurae_IsPlayer(timer.UNIT) then
					aurae_AbortCast(timer.EFFECT, timer.UNIT)
				end
			end
		end
	end

	function aurae_EffectActive(effect, unit)
		return aurae_timers[effect .. '@' .. unit] and true or false
	end

	function aurae_StartTimer(effect, unit, start)
		local timer = {
			EFFECT = effect,
			UNIT = unit,
			START = start,
			shown = aurae_IsShown(unit),
		}

		timer.END = timer.START

		if aurae_IsPlayer(unit) then
			timer.END = timer.END + aurae_DiminishedDuration(unit, effect, aurae.EFFECTS[effect].PVP_DURATION or aurae.EFFECTS[effect].DURATION)
		else
			timer.END = timer.END + aurae.EFFECTS[effect].DURATION
		end

		if aurae.EFFECTS[effect].COMBO then
			timer.END = timer.END + aurae.EFFECTS[effect].A * aurae.COMBO
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

	function aurae_EventHandler.PLAYER_REGEN_ENABLED()
		aurae_AbortUnitCasts()
		for k, timer in aurae_timers do
			if not aurae_IsPlayer(timer.UNIT) then
				aurae_StopTimer(timer.EFFECT, timer.UNIT)
			end
		end
	end

	function aurae_StopTimer(effect, unit)
		local key = effect .. '@' .. unit
		if aurae_timers[key] then
			aurae_timers[key].stopped = GetTime()
			aurae_timers[key] = nil
			place_timers()
		end
	end

	function aurae_UNIT_DEATH(unit)
		if aurae_IsPlayer(unit) then
			aurae_AbortUnitCasts(unit)
		end
		for k, timer in aurae_timers do
			if timer.UNIT == unit then
				aurae_StopTimer(timer.EFFECT, unit)
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

		function aurae_EventHandler.CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS()
			player[hostile_player(arg1)] = true
			for unit, effect in string.gfind(arg1, aurae_TEXT_BUFF_ON) do
				if aurae.EFFECTS[effect] and aurae.EFFECTS[effect].MONITOR and bit.band(aurae.EFFECTS[effect].ETYPE, aurae.MONITORING) ~= 0 then
					aurae_StartTimer(effect, unit, GetTime())
				end
			end
		end

		function aurae_EventHandler.CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE()
			player[hostile_player(arg1)] = true
			for unit, effect in string.gfind(arg1, aurae_TEXT_ON) do
				if aurae.EFFECTS[effect] and aurae.EFFECTS[effect].MONITOR and bit.band(aurae.EFFECTS[effect].ETYPE, aurae.MONITORING) ~= 0 then
					aurae_StartTimer(effect, unit, GetTime())
				end
			end
		end

		function aurae_EventHandler.PLAYER_TARGET_CHANGED()
			unit_changed'target'
		end
		
		function aurae_EventHandler.UPDATE_MOUSEOVER_UNIT()
			unit_changed'mouseover'
		end

		function aurae_EventHandler.UPDATE_BATTLEFIELD_SCORE()
			for i = 1, GetNumBattlefieldScores() do
				player[GetBattlefieldScore(i)] = true
			end
		end

		function aurae_IsShown(unit)
			if not player[unit] or aurae.STYLE == 2 then
				return true
			end
			return UnitName'target' == unit or UnitName'mouseover' == unit or recent[unit] and GetTime() - recent[unit] <= 30
		end

		function aurae_IsPlayer(unit)
			return player[unit]
		end

		function aurae_AddMessage(msg)
			DEFAULT_CHAT_FRAME:AddMessage('<aurae> ' .. msg)
		end
	end
end

function aurae_OnUpdate()
	if aurae.STATUS == 0 then
		return
	end
	aurae_UpdateTimers()
	if aurae.STATUS == 2 then
		return
	end
	aurae_UpdateBars()
end

function aurae_UpdateBars()
	for _, group in {aurae.GROUPSBUFF, aurae.GROUPSDEBUFF, aurae.GROUPSCC} do
		for _, bar in group do
			aurae_UpdateBar(bar)
		end
	end
end

function aurae_UpdateBar(bar)
	if aurae.STATUS ~= 1 then
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
		frame:SetAlpha(aurae.ALPHA)

		local duration = timer.END - timer.START
		local remaining = timer.END - t
		local fraction = remaining / duration

		frame.statusbar:SetValue(aurae.INVERT and 1 - fraction or fraction)

		local sparkPosition = bar.width * fraction
		frame.spark:Show()
		frame.spark:SetPoint('CENTER', bar.frame.statusbar, aurae.INVERT and 'RIGHT' or 'LEFT', aurae.INVERT and -sparkPosition or sparkPosition, 0)

		frame.timertext:SetText(format_time(remaining))

		local r, g, b
		if aurae_Save[aurae.PROFILE].color == CTYPE_SCHOOL then
			r, g, b = unpack(aurae.EFFECTS[timer.EFFECT].SCHOOL or {1, 0, 1})
		elseif aurae_Save[aurae.PROFILE].color == CTYPE_PROGRESS then
			r, g, b = 1 - fraction, fraction, 0
		elseif aurae_Save[aurae.PROFILE].color == CTYPE_CUSTOM then
			if aurae.EFFECTS[timer.EFFECT].COLOR then
				r, g, b = aurae.EFFECTS[timer.EFFECT].COLOR.r, aurae.EFFECTS[timer.EFFECT].COLOR.g, aurae.EFFECTS[timer.EFFECT].COLOR.b
			else
				r, g, b = 1, 1, 1
			end
		end
		frame.statusbar:SetStatusBarColor(r, g, b)
		frame.statusbar:SetBackdropColor(r, g, b, .3)

		frame.icon:SetNormalTexture([[Interface\Icons\]] .. (aurae.EFFECTS[timer.EFFECT].ICON or 'INV_Misc_QuestionMark'))
		frame.text:SetText(timer.UNIT)
	end
end

local function GetConfCC(k, v)
	if aurae.EFFECTS[k] then
		aurae.EFFECTS[k].MONITOR = v.MONITOR
		aurae.EFFECTS[k].COLOR = v.COLOR
	end
end

function aurae_LoadConfCCs()
	table.foreach(aurae_Save[aurae.PROFILE].ConfCC, GetConfCC)
end

function aurae_LoadVariablesOnUpdate(arg1)
	if not aurae.LOADEDVARIABLES then
		aurae_LoadVariables()
		aurae.LOADEDVARIABLES = true
	end
end

function aurae_LoadVariables()
	local default_settings = {
		SavedCC = {},
		ConfCC = {},
		status = aurae.STATUS,
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

	aurae.PROFILE = UnitName'player' .. '@' .. GetCVar'RealmName'

	aurae_Save[aurae.PROFILE] = aurae_Save[aurae.PROFILE] or {}

	for k, v in default_settings do
		if aurae_Save[aurae.PROFILE][k] == nil then
			aurae_Save[aurae.PROFILE][k] = v
		end
	end

	aurae.ARCANIST = aurae_Save[aurae.PROFILE].arcanist

	aurae_LoadConfCCs()
	aurae_UpdateClassSpells(false)

	aurae.STATUS = aurae_Save[aurae.PROFILE].status
	aurae.INVERT = aurae_Save[aurae.PROFILE].invert
	aurae.GROWTH = aurae_Save[aurae.PROFILE].growth
	aurae.SCALE = aurae_Save[aurae.PROFILE].scale
	aurae.WIDTH = aurae_Save[aurae.PROFILE].width
	aurae.ALPHA = aurae_Save[aurae.PROFILE].alpha

	aurae.MONITORING = aurae_Save[aurae.PROFILE].Monitoring

	if bit.band(aurae.MONITORING, ETYPE_CC) ~= 0 or bit.band(aurae.MONITORING, ETYPE_DEBUFF) ~= 0 then
		auraeObject:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE'
	end
	if bit.band(aurae.MONITORING, ETYPE_BUFF) ~= 0 then
		auraeObject:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS'
	end

	aurae.STYLE = aurae_Save[aurae.PROFILE].style

	auraeCC:SetScale(aurae.SCALE)
	auraeDebuff:SetScale(aurae.SCALE)
	auraeBuff:SetScale(aurae.SCALE)
	aurae_SetWidth(aurae.WIDTH)

	if aurae.STATUS == 2 then
		aurae_BarUnlock()
	end

	auraeOptions_Init()
	aurae_BarLock()
end

function aurae_UpdateImpGouge()
	local talentname, texture, _, _, rank = GetTalentInfo(2, 1)
	if texture then
		if rank ~= 0 then
			aurae.EFFECTS[aurae_GOUGE].DURATION = 4 + rank * .5
		end
	elseif aurae.EFFECTS[aurae_GOUGE].DURATION == nil then
		aurae.EFFECTS[aurae_GOUGE].DURATION = 4
	end
end

function aurae_UpdateImpGarotte()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 8)
	if texture then
		if rank ~= 0 then
			aurae.EFFECTS[aurae_GAROTTE].DURATION = 18 + rank * 3
		end
	elseif aurae.EFFECTS[aurae_GAROTTE].DURATION == nil then
		aurae.EFFECTS[aurae_GAROTTE].DURATION = 18
	end
end

function aurae_UpdateKidneyShot()
	local i = 1
	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)
		if not name then
			if aurae.EFFECTS[aurae_KS].DURATION == nil then
				aurae.EFFECTS[aurae_KS].DURATION = 1
			end
			return
		end

		if name == aurae_KS then
			if strsub(rank,string.len(rank)) == "1" then
				aurae.EFFECTS[aurae_KS].DURATION = 0
			else
				aurae.EFFECTS[aurae_KS].DURATION = 1
			end
			return
		end

		i = i + 1
	end
end

function aurae_UpdateImpTrap()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 7)
	if texture then
		if rank ~= 0 then
-- Freezing Trap is a true multi rank, hence already updated
			aurae.EFFECTS[aurae_FREEZINGTRAP].DURATION = aurae.EFFECTS[aurae_FREEZINGTRAP].DURATION * (1 + rank * .15)
		end
	end
end

function aurae_UpdateImpSeduce()
	local talentname, texture, _, _, rank = GetTalentInfo(2, 7)
	if texture then
		if rank ~= 0 then
			aurae.EFFECTS[aurae_SEDUCE].DURATION = 15 * (1 + rank * .10)
		end
	end
end

function aurae_UpdateBrutalImpact()
	local talentname, texture, _, _, rank = GetTalentInfo(2, 4)
	if texture then
		if rank ~= 0 then
-- Bash is a true multi rank, hence already updated
			aurae.EFFECTS[aurae_POUNCE].DURATION = 2 + rank * .50
			aurae.EFFECTS[aurae_BASH].DURATION = aurae.EFFECTS[aurae_BASH].DURATION + rank * .50
		end
	end
end

function aurae_UpdatePermafrost()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 2)
	if texture then
		if rank ~= 0 then
-- Frostbolt is a true multi rank, hence already updated
			aurae.EFFECTS[aurae_CONEOFCOLD].DURATION = 8 + .50 + rank * .50
			aurae.EFFECTS[aurae_FROSTBOLT].DURATION = aurae.EFFECTS[aurae_FROSTBOLT].DURATION + .50 + rank * .50
		end
	end
end

function aurae_UpdateImpShadowWordPain()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 4)
	if texture then
		if rank ~= 0 then
			aurae.EFFECTS[aurae_SHADOWWORDPAIN].DURATION = 18 + rank * 3
		end
	end
end

function aurae_GetSpellRank(spellname, spelleffect)
	local i = 1
	local gotone = false
	local maxrank = aurae_ACTIONS[spellname].RANKS

	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)

		if not name then
			if not gotone then
				if aurae.EFFECTS[spelleffect].DURATION == nil then
					aurae.EFFECTS[spelleffect].DURATION = aurae_ACTIONS[spellname].DURATION[maxrank]
				end
			end
			return
		end

		if name == spellname then
			local currank = 1
			while currank <= maxrank do
				if tonumber(strsub(rank,string.len(rank))) == currank then
					aurae.EFFECTS[spelleffect].DURATION = aurae_ACTIONS[spellname].DURATION[currank]
					gotone = true
				end
				currank = currank + 1
			end
		end

		i = i + 1
	end
end

function aurae_UpdateClassSpells()
	local _, eclass = UnitClass'player'
	auraeOptionsFrameArcanist:Hide()
	if eclass == "ROGUE" then
		aurae_GetSpellRank(aurae_SAP, aurae_SAP)
		aurae_UpdateImpGouge()
		aurae_UpdateKidneyShot()
		if aurae_ConfigBuff ~= nil then
			aurae_UpdateImpGarotte()
		end
	elseif eclass == "WARRIOR" then
		aurae_GetSpellRank(aurae_REND, aurae_REND)
	elseif eclass == "WARLOCK" then
		aurae_GetSpellRank(aurae_FEAR, aurae_FEAR)
		aurae_GetSpellRank(aurae_HOWLOFTERROR, aurae_HOWLOFTERROR)
		aurae_GetSpellRank(aurae_BANISH, aurae_BANISH)
		aurae_GetSpellRank(aurae_CORRUPTION, aurae_CORRUPTION)
		aurae_UpdateImpSeduce()
	elseif eclass == "PALADIN" then
		aurae_GetSpellRank(aurae_HOJ, aurae_HOJ)
		if aurae_ConfigBuff ~= nil then
			aurae_GetSpellRank(aurae_DIVINESHIELD, aurae_DIVINESHIELD)
		end
	elseif eclass == "HUNTER" then
		aurae_GetSpellRank(aurae_FREEZINGTRAP_SPELL, aurae_FREEZINGTRAP)
		aurae_GetSpellRank(aurae_SCAREBEAST, aurae_SCAREBEAST)
		aurae_UpdateImpTrap()
	elseif eclass == "PRIEST" then
		aurae_GetSpellRank(aurae_SHACKLE, aurae_SHACKLE)
		if aurae_ConfigDebuff ~= nil then
			aurae_UpdateImpShadowWordPain()
		end
	elseif eclass == "MAGE" then
		if aurae_ConfigDebuff ~= nil then
			aurae_GetSpellRank(aurae_POLYMORPH, aurae_POLYMORPH)
			aurae_GetSpellRank(aurae_FROSTBOLT, aurae_FROSTBOLT)
			aurae_GetSpellRank(aurae_FIREBALL, aurae_FIREBALL)
			aurae_UpdatePermafrost()
		end
		auraeOptionsFrameArcanist:Show()
		if aurae.ARCANIST then
			aurae.EFFECTS[aurae_POLYMORPH].DURATION = aurae.EFFECTS[aurae_POLYMORPH].DURATION + 15
		end
	elseif eclass == "DRUID" then
		aurae_GetSpellRank(aurae_ROOTS, aurae_ROOTS)
		aurae_GetSpellRank(aurae_HIBERNATE, aurae_HIBERNATE)
		aurae_GetSpellRank(aurae_BASH, aurae_BASH)
		aurae_UpdateBrutalImpact()
	end
end

function aurae_Help()
	aurae_AddMessage(aurae_FULLVERSION .. aurae_HELP1)
	aurae_AddMessage(aurae_HELP2)
	aurae_AddMessage(aurae_HELP3)
	aurae_AddMessage(aurae_HELP4)
	aurae_AddMessage(aurae_HELP5)
	aurae_AddMessage(aurae_HELP6)
	aurae_AddMessage(aurae_HELP7)
	aurae_AddMessage(aurae_HELP8)
	aurae_AddMessage(aurae_HELP9)
	aurae_AddMessage(aurae_HELP10)
	aurae_AddMessage(aurae_HELP11)
	aurae_AddMessage(aurae_HELP12)
	aurae_AddMessage(aurae_HELP13)
	aurae_AddMessage(aurae_HELP14)
	aurae_AddMessage(aurae_HELP15)
end

function aurae_SetWidth(width)
	for _, k in {'CC', 'Debuff', 'Buff'} do
		for i = 1, aurae_MAXBARS do
			getglobal("auraeBar" .. k .. i):SetWidth(width + 10)
		end
		getglobal("aurae" .. k):SetWidth(width + 10)
	end
end