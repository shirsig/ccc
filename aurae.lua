local _G, _M, _F = getfenv(0), {}, CreateFrame'Frame'
setfenv(1, setmetatable(_M, {__index=_G}))
_F:SetScript('OnUpdate', function() _M.UPDATE() end)
_F:SetScript('OnEvent', function()
	if aurae and aurae.STATUS == 0 then return end
	_M[event](this)
end)
CreateFrame('GameTooltip', 'aurae_Tooltip', nil, 'GameTooltipTemplate')
for _, event in {'ADDON_LOADED'} do
	_F:RegisterEvent(event)
end

CreateFrame'Frame':SetScript('OnUpdate', function()
	LoadVariables()
	this:SetScript('OnUpdate', nil)
end)

WIDTH = 170
HEIGHT = 16
MAXBARS = 10

_G.aurae_SCHOOL = {
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

	function DiminishedDuration(unit, effect, full_duration)
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

function UnitDebuffs(unit)
	local debuffs = {}
	local i = 1
	while UnitDebuff(unit, i) do
		aurae_Tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
		aurae_Tooltip:SetUnitDebuff(unit, i)
		debuffs[aurae_TooltipTextLeft1:GetText()] = true
		i = i + 1
	end
	return debuffs
end

local bars = {}

local function create_bar(name)
	local bar = {}
	bars[name] = bar

	local icon = bar.icon or nil
	local texture = [[Interface\Addons\aurae\Textures\BantoBar]]
	local text = bar.text
	local font, _, style = GameFontHighlight:GetFont()
	local fontsize = 11

	bar.fadetime = .5
	bar.textcolor = textcolor
	bar.timertextcolor = timertextcolor

	local f = CreateFrame('Button', nil, UIParent)

	f:SetHeight(HEIGHT)

	f:EnableMouse(false)
	f:RegisterForClicks()
	f:SetScript('OnClick', nil)

	f.icon = f:CreateTexture()
	f.icon:SetWidth(HEIGHT)
	f.icon:SetPoint('TOPLEFT', 0, 0)
	f.icon:SetPoint('BOTTOMLEFT', 0, 0)
	f.icon:SetTexture[[Interface\Icons\INV_Misc_QuestionMark]]
	f.icon:SetTexCoord(.08, .92, .08, .92)

	f.statusbar = CreateFrame('StatusBar', nil, f)
	f.statusbar:SetPoint('TOPLEFT', f.icon, 'TOPRIGHT', 0, 0)
	f.statusbar:SetPoint('BOTTOMRIGHT', 0, 0)
	f.statusbar:SetStatusBarTexture(texture)
	f.statusbar:SetStatusBarColor(.5, .5, .5, 1)
	f.statusbar:SetMinMaxValues(0, 1)
	f.statusbar:SetValue(1)
	f.statusbar:SetBackdrop{bgFile=texture}
	f.statusbar:SetBackdropColor(.5, .5, .5, .3)

	f.spark = f.statusbar:CreateTexture(nil, 'OVERLAY')
	f.spark:SetTexture[[Interface\CastingBar\UI-CastingBar-Spark]]
	f.spark:SetWidth(16)
	f.spark:SetHeight(HEIGHT + 25)
	f.spark:SetBlendMode'ADD'

	f.text = f.statusbar:CreateFontString(nil, 'OVERLAY')
--	f.text:SetFontObject(GameFontHighlightSmallOutline)
	f.text:SetFontObject(GameFontHighlight)
	f.text:SetFont(font, fontsize, style)
	f.text:SetPoint('TOPLEFT', 2, 0)
	f.text:SetPoint('BOTTOMRIGHT', -2, 0)
	f.text:SetJustifyH'LEFT'
	f.text:SetText(text)

	f.timertext = f.statusbar:CreateFontString(nil, 'OVERLAY')
--	f.text:SetFontObject(GameFontHighlightSmallOutline)
	f.timertext:SetFontObject(GameFontHighlight)
	f.timertext:SetFont(font, fontsize, style)
	f.timertext:SetPoint('TOPLEFT', 2, 0)
	f.timertext:SetPoint('BOTTOMRIGHT', -2, 0)
	f.timertext:SetJustifyH'RIGHT'
	f.timertext:SetText''

--	if bar.onclick then
--		TODO
--	end

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
		return format('%d:%02d:02d', h, m, s)
	elseif m > 0 then
		return format('%d:%02d', m, s)
	elseif s < 10 then
		return format('%.1f', s)
	else
		return format('%.0f', s)
	end
end

function ADDON_LOADED()
	if arg1 ~= 'aurae' then return end

	_G.aurae_Globals()

	local dummy_timer = {stopped=0}
	for i, etype in {'Debuff', 'CC', 'Buff'} do
		local height = HEIGHT * MAXBARS + 4 * (MAXBARS - 1)
		local f = CreateFrame('Frame', 'aurae'..etype, UIParent)
		f:SetWidth(WIDTH + HEIGHT)
		f:SetHeight(height)
		f:SetMovable(true)
		f:SetUserPlaced(true)
		f:SetClampedToScreen(true)
		f:RegisterForDrag('LeftButton')
		f:SetScript('OnDragStart', function()
			this:StartMoving()
		end)
		f:SetScript('OnDragStop', function()
			this:StopMovingOrSizing()
		end)
		f:SetPoint('CENTER', -210 + (i - 1) * 210, 150)
		for i = 1, MAXBARS do
			local name = 'auraeBar' .. etype .. i
			local bar = create_bar(name)
			bar.frame:SetParent(getglobal('aurae' .. etype))
			local offset = 20 * (i - 1)
			bar.frame:SetPoint('BOTTOMLEFT', 0, offset)
			bar.frame:SetPoint('BOTTOMRIGHT', 0, offset)
			setglobal(name, bar.frame)
			bar.TIMER = dummy_timer
			tinsert(aurae['GROUPS' .. strupper(etype)], bar)
		end
	end

	_G.aurae_Config()

	_F:RegisterEvent'UNIT_COMBAT'

	_F:RegisterEvent'CHAT_MSG_COMBAT_HONOR_GAIN'
	_F:RegisterEvent'CHAT_MSG_COMBAT_HOSTILE_DEATH'
	_F:RegisterEvent'PLAYER_REGEN_ENABLED'

	_F:RegisterEvent'CHAT_MSG_SPELL_AURA_GONE_OTHER'
	_F:RegisterEvent'CHAT_MSG_SPELL_BREAK_AURA'

	_F:RegisterEvent'SPELLCAST_STOP'
	_F:RegisterEvent'SPELLCAST_INTERRUPTED'
	_F:RegisterEvent'CHAT_MSG_SPELL_SELF_DAMAGE'
	_F:RegisterEvent'CHAT_MSG_SPELL_FAILED_LOCALPLAYER'

	_F:RegisterEvent'PLAYER_TARGET_CHANGED'
	_F:RegisterEvent'UPDATE_MOUSEOVER_UNIT'
	_F:RegisterEvent'UPDATE_BATTLEFIELD_SCORE'

	_G.SLASH_AURAE1 = '/aurae'
	SlashCmdList.AURAE = SlashCommandHandler

	_G.aurae_Print("aurae Loaded - /aurae")
end

--	if _G.aurae_Save[aurae.PROFILE].WarnSelf then
--		local info = ChatTypeInfo.RAID_WARNING
--		RaidWarningFrame:AddMessage(msg, info.r, info.g, info.b, 1)
--		PlaySound'RaidWarning'
--	end

function _G.aurae_Config()
	aurae.EFFECTS = {}

	_G.aurae_ConfigCC()
	_G.aurae_ConfigDebuff()
	_G.aurae_ConfigBuff()
end

function _G.aurae_BarUnlock()
	aurae.STATUS = 2
	for _, type in {'CC', 'Buff', 'Debuff'} do
		getglobal('aurae' .. type):EnableMouse(1)
		for i = 1, MAXBARS do
			local f = getglobal('auraeBar' .. type .. i)
			f:SetAlpha(aurae.ALPHA)
			f.statusbar:SetStatusBarColor(1, 1, 1)
			f.statusbar:SetValue(1)
			f.icon:SetTexture[[Interface\Icons\INV_Misc_QuestionMark]]
			f.text:SetText('aurae ' .. type .. ' Bar ' .. i)
			f.timertext:SetText''
			f.spark:Hide()
			-- getglobal(barname.."StatusBarSpark"):SetPoint("CENTER", barname.."StatusBar", "LEFT", 0, 0)
		end
	end
end

function _G.aurae_BarLock()
	aurae.STATUS = 1
	auraeCC:EnableMouse(0)
	auraeDebuff:EnableMouse(0)
	auraeBuff:EnableMouse(0)

	for i = 1, MAXBARS do
		getglobal("auraeBarCC" .. i):SetAlpha(0)
		getglobal("auraeBarDebuff" .. i):SetAlpha(0)
		getglobal("auraeBarBuff" .. i):SetAlpha(0)
	end
end

function SlashCommandHandler(msg)
	if msg then
		local command = strlower(msg)
		if command == "on" then
			if aurae.STATUS == 0 then
				aurae.STATUS = 1
				_G.aurae_Save[aurae.PROFILE].status = aurae.STATUS
				_G.aurae_Print(_G.aurae_ENABLED)
			end
		elseif command == "off" then
			if aurae.STATUS ~= 0 then
				aurae.STATUS = 0
				_G.aurae_Save[aurae.PROFILE].status = aurae.STATUS
				_G.aurae_Print(_G.aurae_DISABLED)
			end
		elseif command == "unlock" then
			_G.aurae_BarUnlock()
			_G.aurae_Print('Bars unlocked')
			auraeOptionsFrameUnlock:SetChecked(true)
		elseif command == "lock" then
			_G.aurae_BarLock()
			_G.aurae_Print('Bars locked')
			auraeOptionsFrameUnlock:SetChecked(false)
		elseif command == "invert" then
			aurae.INVERT = not aurae.INVERT
			_G.aurae_Save[aurae.PROFILE].invert = aurae.INVERT
			if aurae.INVERT then
				_G.aurae_Print(_G.aurae_INVERSION_ON)
			else
				_G.aurae_Print(_G.aurae_INVERSION_OFF)
			end
			auraeOptionsFrameInvert:SetChecked(aurae.INVERT)
		elseif command == "color school" then
			_G.aurae_Save[aurae.PROFILE].color = CTYPE_SCHOOL
			_G.aurae_Print'School color enabled.'
		elseif command == "color progress" then
			_G.aurae_Save[aurae.PROFILE].color = CTYPE_PROGRESS
			_G.aurae_Print'Progress color enabled.'
		elseif command == "color custom" then
			_G.aurae_Save[aurae.PROFILE].color = CTYPE_CUSTOM
			_G.aurae_Print'Custom color enabled.'
		elseif command == "clear" then
			_G.aurae_Save[aurae.PROFILE] = nil
			_G.aurae_Globals()
			_G.aurae_Config()
			LoadVariables()
		elseif command == "u" then
			_G.aurae_Config()
			_G.aurae_LoadConfCCs()
			_G.aurae_UpdateClassSpells(true)
		elseif command == "config" then
			auraeOptionsFrame:Show()
		elseif strsub(command, 1, 5) == "scale" then
			local scale = tonumber(strsub(command, 7))
			if scale <= 3 and scale >= .25 then
				_G.aurae_Save[aurae.PROFILE].scale = scale
				aurae.SCALE = scale
				auraeCC:SetScale(aurae.SCALE)
				auraeDebuff:SetScale(aurae.SCALE)
				auraeBuff:SetScale(aurae.SCALE)
				auraeSliderScale:SetValue(aurae.SCALE)
			else
				Help()
			end
		elseif strsub(command, 1, 5) == "alpha" then
			local alpha = tonumber(strsub(command, 7))
			if alpha <= 1 and alpha >= 0 then
				_G.aurae_Save[aurae.PROFILE].alpha = alpha
				aurae.ALPHA = alpha
				_G.aurae_Print('Alpha: '..alpha)
				auraeSliderAlpha:SetValue(aurae.ALPHA)
			else
				Help()
			end
		elseif command == "print" then
			_G.aurae_Print("Profile: "..aurae.PROFILE)
			if aurae.STATUS == 0 then
				_G.aurae_Print(_G.aurae_DISABLED)
			elseif aurae.STATUS == 2 then
				_G.aurae_Print(_G.aurae_UNLOCKED)
			else
				_G.aurae_Print(_G.aurae_ENABLED)
			end
			if aurae.INVERT then
				_G.aurae_Print(_G.aurae_INVERSION_ON)
			else
				_G.aurae_Print(_G.aurae_INVERSION_OFF)
			end
			_G.aurae_Config()
			_G.aurae_LoadConfCCs()
			_G.aurae_UpdateClassSpells(true)
			_G.aurae_Print('Alpha: '..aurae.ALPHA)
		else
			Help()
		end
	end
end

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

	function TargetID()
		local name = UnitName'target'
		if name then
			return UnitIsPlayer'target' and name or name .. ' [' .. UnitLevel'target' .. target_sex() .. ']'
		end
	end
end

do
	local casting = {}
	local last_cast
	local pending = {}

	do
		local orig = UseAction
		function _G.UseAction(slot, clicked, onself)
			if HasAction(slot) and not GetActionText(slot) and not onself then
				aurae_Tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
				aurae_Tooltip:SetAction(slot)
				casting[aurae_TooltipTextLeft1:GetText()] = TargetID()
			end
			return orig(slot, clicked, onself)
		end
	end

	do
		local orig = CastSpell
		function _G.CastSpell(index, booktype)
			casting[GetSpellName(index, booktype)] = TargetID()
			return orig(index, booktype)
		end
	end

	do
		local orig = CastSpellByName
		function _G.CastSpellByName(text, onself)
			if not onself then
				casting[text] = TargetID()
			end
			return orig(text, onself)
		end
	end

	function CHAT_MSG_SPELL_FAILED_LOCALPLAYER()
		for effect in string.gfind(arg1, 'You fail to %a+ (.*):.*') do
			casting[effect] = nil
		end
	end

	function SPELLCAST_STOP()
		for effect, target in casting do
			if (EffectActive(effect, target) or not IsPlayer(target) and aurae.EFFECTS[effect]) and aurae.EFFECTS[effect].ETYPE ~= ETYPE_BUFF then
				if pending[effect] then
					last_cast = nil
				else
					pending[effect] = {target=target, time=GetTime() + .5 + (_G.aurae_ACTIONS[effect] and _G.aurae_ACTIONS[effect].DELAY or 0)}
					last_cast = effect
				end
			end
		end
		casting = {}
	end

	CreateFrame'Frame':SetScript('OnUpdate', function()
		for effect, info in pending do
			if GetTime() >= info.time and (IsPlayer(info.target) or TargetID() ~= info.target or UnitDebuffs'target'[effect]) then
				StartTimer(effect, info.target, GetTime() - .5)
				pending[effect] = nil
			end
		end
	end)

	function AbortCast(effect, unit)
		for k, v in pending do
			if k == effect and v.target == unit then
				pending[k] = nil
			end
		end
	end

	function AbortUnitCasts(unit)
		for k, v in pending do
			if v.target == unit or not unit and not IsPlayer(v.target) then
				pending[k] = nil
			end
		end
	end

	function SPELLCAST_INTERRUPTED()
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
		function CHAT_MSG_SPELL_SELF_DAMAGE()
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

function CHAT_MSG_SPELL_AURA_GONE_OTHER()
	for effect, unit in string.gfind(arg1, _G.aurae_TEXT_OFF) do
		AuraGone(unit, effect)
	end
end

function CHAT_MSG_SPELL_BREAK_AURA()
	for unit, effect in string.gfind(arg1, _G.aurae_TEXT_BREAK) do
		AuraGone(unit, effect)
	end
end

function AuraGone(unit, effect)
	if aurae.EFFECTS[effect] then
		if IsPlayer(unit) then
			AbortCast(effect, unit)
			StopTimer(effect, unit)
		elseif unit == UnitName'target' then
			-- TODO pet target (in other places too)
			local unit = TargetID()
			local debuffs = UnitDebuffs'target'
			for k, timer in _G.aurae_timers do
				if timer.UNIT == unit and not debuffs[timer.EFFECT] then
					-- TODO only if not deprecated (tentative)
					StopTimer(timer.EFFECT, timer.UNIT)
				end
			end
		end
	end
end

--function DoTimer_ChangedTargets() TODO (tentative)
--	for k, timer in _G.aurae_timers do
--		timer.deprecated = true
--	end
	-- TODO deal with pending spells
--end

function CHAT_MSG_COMBAT_HOSTILE_DEATH()
	for unit in string.gfind(arg1, '(.+) dies') do -- TODO does not work when xp is gained
		if IsPlayer(unit) then
			UnitDied(unit)
		elseif unit == UnitName'target' and UnitIsDead'target' then
			-- TODO only if not deprecated (tentative)
			UnitDied(TargetID())
		end
	end
end

function CHAT_MSG_COMBAT_HONOR_GAIN()
	for unit in string.gfind(arg1, '(.+) dies') do
		UnitDied(unit)
	end
end

function UNIT_COMBAT()
	if GetComboPoints() > 0 then
		aurae.COMBO = GetComboPoints()
	end
end

do
	_G.aurae_timers = {}

	local function place_timers()
		for _, timer in _G.aurae_timers do
			if timer.shown and not timer.visible then
				local group
				if aurae.EFFECTS[timer.EFFECT].ETYPE == ETYPE_BUFF then
					group = aurae.GROUPSBUFF
				elseif aurae.EFFECTS[timer.EFFECT].ETYPE == ETYPE_DEBUFF then
					group = aurae.GROUPSDEBUFF
				else
					group = aurae.GROUPSCC
				end
				for i = 1, MAXBARS do
					if group[i].TIMER.stopped then
						group[i].TIMER = timer
						timer.visible = true
						break
					end
				end
			end
		end
	end

	function UpdateTimers()
		local t = GetTime()
		for _, timer in _G.aurae_timers do
			if t > timer.END then
				StopTimer(timer.EFFECT, timer.UNIT)
				if IsPlayer(timer.UNIT) then
					AbortCast(timer.EFFECT, timer.UNIT)
				end
			end
		end
	end

	function EffectActive(effect, unit)
		return _G.aurae_timers[effect .. '@' .. unit] and true or false
	end

	function StartTimer(effect, unit, start)
		local timer = {
			EFFECT = effect,
			UNIT = unit,
			START = start,
			shown = IsShown(unit),
		}

		timer.END = timer.START

		if IsPlayer(unit) then
			timer.END = timer.END + DiminishedDuration(unit, effect, aurae.EFFECTS[effect].PVP_DURATION or aurae.EFFECTS[effect].DURATION)
		else
			timer.END = timer.END + aurae.EFFECTS[effect].DURATION
		end

		if aurae.EFFECTS[effect].COMBO then
			timer.END = timer.END + aurae.EFFECTS[effect].A * aurae.COMBO
		end

		local old_timer = _G.aurae_timers[effect .. '@' .. unit]
		if old_timer and not old_timer.stopped then
			old_timer.START = timer.START
			old_timer.END = timer.END
			old_timer.shown = old_timer.shown or timer.shown
		else
			_G.aurae_timers[effect .. '@' .. unit] = timer
			place_timers()
		end
	end

	function PLAYER_REGEN_ENABLED()
		AbortUnitCasts()
		for k, timer in _G.aurae_timers do
			if not IsPlayer(timer.UNIT) then
				StopTimer(timer.EFFECT, timer.UNIT)
			end
		end
	end

	function StopTimer(effect, unit)
		local key = effect .. '@' .. unit
		if _G.aurae_timers[key] then
			_G.aurae_timers[key].stopped = GetTime()
			_G.aurae_timers[key] = nil
			place_timers()
		end
	end

	function UnitDied(unit)
		AbortUnitCasts(unit)
		for k, timer in _G.aurae_timers do
			if timer.UNIT == unit then
				StopTimer(timer.EFFECT, unit)
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

			for _, timer in _G.aurae_timers do
				if timer.UNIT == unit then
					timer.shown = true
				end
			end
			place_timers()
		end

		local function unit_changed(unitID)
			local unit = UnitName(unitID)
			if unit then
				player[unit] = UnitIsPlayer(unitID)

				if player[unit] then
					add_recent(unit)
				end
				if player[current[unitID]] and current[unitID] then
					add_recent(current[unitID])
				end
				current[unitID] = unit
			end
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

		function CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS()
			player[hostile_player(arg1)] = true
			for unit, effect in string.gfind(arg1, _G.aurae_TEXT_BUFF_ON) do
				if IsPlayer(unit) and aurae.EFFECTS[effect] and aurae.EFFECTS[effect].MONITOR and bit.band(aurae.EFFECTS[effect].ETYPE, aurae.MONITORING) ~= 0 then
					StartTimer(effect, unit, GetTime())
				end
			end
		end

		function CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE()
			player[hostile_player(arg1)] = true
			for unit, effect in string.gfind(arg1, _G.aurae_TEXT_ON) do
				if IsPlayer(unit) and aurae.EFFECTS[effect] and aurae.EFFECTS[effect].MONITOR and bit.band(aurae.EFFECTS[effect].ETYPE, aurae.MONITORING) ~= 0 then
					StartTimer(effect, unit, GetTime())
				end
			end
		end

		function PLAYER_TARGET_CHANGED()
			unit_changed'target'
		end
		
		function UPDATE_MOUSEOVER_UNIT()
			unit_changed'mouseover'
		end

		function UPDATE_BATTLEFIELD_SCORE()
			for i = 1, GetNumBattlefieldScores() do
				player[GetBattlefieldScore(i)] = true
			end
		end

		function IsShown(unit)
			if not player[unit] or aurae.STYLE == 2 then
				return true
			end
			return UnitName'target' == unit or UnitName'mouseover' == unit or recent[unit] and GetTime() - recent[unit] <= 30
		end

		function IsPlayer(unit)
			return player[unit]
		end

		function _G.aurae_Print(msg)
			DEFAULT_CHAT_FRAME:AddMessage('<aurae> ' .. msg)
		end
	end
end

function UPDATE()
	if aurae.STATUS == 0 then
		return
	end
	UpdateTimers()
	if aurae.STATUS == 2 then
		return
	end
	UpdateBars()
end

function UpdateBars()
	for _, group in {aurae.GROUPSBUFF, aurae.GROUPSDEBUFF, aurae.GROUPSCC} do
		for _, bar in group do
			UpdateBar(bar)
		end
	end
end

function UpdateBar(bar)
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

		local sparkPosition = WIDTH * fraction
		frame.spark:Show()
		frame.spark:SetPoint('CENTER', bar.frame.statusbar, aurae.INVERT and 'RIGHT' or 'LEFT', aurae.INVERT and -sparkPosition or sparkPosition, 0)

		frame.timertext:SetText(format_time(remaining))

		local r, g, b
		if _G.aurae_Save[aurae.PROFILE].color == CTYPE_SCHOOL then
			r, g, b = unpack(aurae.EFFECTS[timer.EFFECT].SCHOOL or {1, 0, 1})
		elseif _G.aurae_Save[aurae.PROFILE].color == CTYPE_PROGRESS then
			r, g, b = 1 - fraction, fraction, 0
		elseif _G.aurae_Save[aurae.PROFILE].color == CTYPE_CUSTOM then
			if aurae.EFFECTS[timer.EFFECT].COLOR then
				r, g, b = aurae.EFFECTS[timer.EFFECT].COLOR.r, aurae.EFFECTS[timer.EFFECT].COLOR.g, aurae.EFFECTS[timer.EFFECT].COLOR.b
			else
				r, g, b = 1, 1, 1
			end
		end
		frame.statusbar:SetStatusBarColor(r, g, b)
		frame.statusbar:SetBackdropColor(r, g, b, .3)

		frame.icon:SetTexture([[Interface\Icons\]] .. (aurae.EFFECTS[timer.EFFECT].ICON or 'INV_Misc_QuestionMark'))
		frame.text:SetText(timer.UNIT)
	end
end

local function GetConfCC(k, v)
	if aurae.EFFECTS[k] then
		aurae.EFFECTS[k].MONITOR = v.MONITOR
		aurae.EFFECTS[k].COLOR = v.COLOR
	end
end

function _G.aurae_LoadConfCCs()
	table.foreach(_G.aurae_Save[aurae.PROFILE].ConfCC, GetConfCC)
end

function LoadVariables()
	local default_settings = {
		SavedCC = {},
		ConfCC = {},
		status = aurae.STATUS,
		invert = false,
		color = CTYPE_SCHOOL,
		scale = 1,
		width = 160,
		alpha = 1,
		arcanist = false,
		style = 1,
		Monitoring = bit.bor(ETYPE_CC, ETYPE_DEBUFF, ETYPE_BUFF),
	}

	aurae.PROFILE = UnitName'player' .. '@' .. GetCVar'RealmName'

	_G.aurae_Save[aurae.PROFILE] = _G.aurae_Save[aurae.PROFILE] or {}

	for k, v in default_settings do
		if _G.aurae_Save[aurae.PROFILE][k] == nil then
			_G.aurae_Save[aurae.PROFILE][k] = v
		end
	end

	aurae.ARCANIST = _G.aurae_Save[aurae.PROFILE].arcanist

	_G.aurae_LoadConfCCs()
	_G.aurae_UpdateClassSpells(false)

	aurae.STATUS = _G.aurae_Save[aurae.PROFILE].status
	aurae.INVERT = _G.aurae_Save[aurae.PROFILE].invert
	aurae.ALPHA = _G.aurae_Save[aurae.PROFILE].alpha

	aurae.MONITORING = _G.aurae_Save[aurae.PROFILE].Monitoring

	if bit.band(aurae.MONITORING, ETYPE_CC) ~= 0 or bit.band(aurae.MONITORING, ETYPE_DEBUFF) ~= 0 then
		_F:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE'
	end
	if bit.band(aurae.MONITORING, ETYPE_BUFF) ~= 0 then
		_F:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS'
	end

	aurae.STYLE = _G.aurae_Save[aurae.PROFILE].style

	auraeCC:SetScale(aurae.SCALE)
	auraeDebuff:SetScale(aurae.SCALE)
	auraeBuff:SetScale(aurae.SCALE)

	if aurae.STATUS == 2 then
		_G.aurae_BarUnlock()
	end

	auraeOptions_Init()
	_G.aurae_BarLock()
end

function _G.aurae_UpdateImpGouge()
	local talentname, texture, _, _, rank = GetTalentInfo(2, 1)
	if texture then
		if rank ~= 0 then
			aurae.EFFECTS["Gouge"].DURATION = 4 + rank * .5
		end
	elseif aurae.EFFECTS["Gouge"].DURATION == nil then
		aurae.EFFECTS["Gouge"].DURATION = 4
	end
end

function _G.aurae_UpdateImpGarotte()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 8)
	if texture then
		if rank ~= 0 then
			aurae.EFFECTS["Garrote"].DURATION = 18 + rank * 3
		end
	elseif aurae.EFFECTS["Garrote"].DURATION == nil then
		aurae.EFFECTS["Garrote"].DURATION = 18
	end
end

function _G.aurae_UpdateKidneyShot()
	local i = 1
	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)
		if not name then
			if aurae.EFFECTS["Kidney Shot"].DURATION == nil then
				aurae.EFFECTS["Kidney Shot"].DURATION = 1
			end
			return
		end

		if name == "Kidney Shot" then
			if strsub(rank, string.len(rank)) == "1" then
				aurae.EFFECTS["Kidney Shot"].DURATION = 0
			else
				aurae.EFFECTS["Kidney Shot"].DURATION = 1
			end
			return
		end

		i = i + 1
	end
end

function _G.aurae_UpdateImpTrap()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 7)
	if texture then
		if rank ~= 0 then
-- Freezing Trap is a true multi rank, hence already updated
			aurae.EFFECTS["Freezing Trap Effect"].DURATION = aurae.EFFECTS["Freezing Trap Effect"].DURATION * (1 + rank * .15)
		end
	end
end

function _G.aurae_UpdateImpSeduce()
	local talentname, texture, _, _, rank = GetTalentInfo(2, 7)
	if texture then
		if rank ~= 0 then
			aurae.EFFECTS["Seduction"].DURATION = 15 * (1 + rank * .10)
		end
	end
end

function _G.aurae_UpdateBrutalImpact()
	local talentname, texture, _, _, rank = GetTalentInfo(2, 4)
	if texture then
		if rank ~= 0 then
-- Bash is a true multi rank, hence already updated
			aurae.EFFECTS["Pounce"].DURATION = 2 + rank * .50
			aurae.EFFECTS["Bash"].DURATION = aurae.EFFECTS["Bash"].DURATION + rank * .50
		end
	end
end

function _G.aurae_UpdatePermafrost()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 2)
	if texture then
		if rank ~= 0 then
-- Frostbolt is a true multi rank, hence already updated
			aurae.EFFECTS["Cone of Cold"].DURATION = 8 + .50 + rank * .50
			aurae.EFFECTS["Frostbolt"].DURATION = aurae.EFFECTS["Frostbolt"].DURATION + .50 + rank * .50
		end
	end
end

function _G.aurae_UpdateImpShadowWordPain()
	local talentname, texture, _, _, rank = GetTalentInfo(3, 4)
	if texture then
		if rank ~= 0 then
			aurae.EFFECTS["Shadow Word: Pain"].DURATION = 18 + rank * 3
		end
	end
end

function _G.aurae_GetSpellRank(spellname, spelleffect)
	local i = 1
	local gotone = false
	local maxrank = _G.aurae_ACTIONS[spellname].RANKS

	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)

		if not name then
			if not gotone then
				if aurae.EFFECTS[spelleffect].DURATION == nil then
					aurae.EFFECTS[spelleffect].DURATION = _G.aurae_ACTIONS[spellname].DURATION[maxrank]
				end
			end
			return
		end

		if name == spellname then
			local currank = 1
			while currank <= maxrank do
				if tonumber(strsub(rank,string.len(rank))) == currank then
					aurae.EFFECTS[spelleffect].DURATION = _G.aurae_ACTIONS[spellname].DURATION[currank]
					gotone = true
				end
				currank = currank + 1
			end
		end

		i = i + 1
	end
end

function _G.aurae_UpdateClassSpells()
	local _, eclass = UnitClass'player'
	auraeOptionsFrameArcanist:Hide()
	if eclass == "ROGUE" then
		_G.aurae_GetSpellRank("Sap", "Sap")
		_G.aurae_UpdateImpGouge()
		_G.aurae_UpdateKidneyShot()
		if _G.aurae_ConfigBuff ~= nil then
			_G.aurae_UpdateImpGarotte()
		end
	elseif eclass == "WARRIOR" then
		_G.aurae_GetSpellRank("Rend", "Rend")
	elseif eclass == "WARLOCK" then
		_G.aurae_GetSpellRank("Fear", "Fear")
		_G.aurae_GetSpellRank("Howl of Terror", "Howl of Terror")
		_G.aurae_GetSpellRank("Banish", "Banish")
		_G.aurae_GetSpellRank("Corruption", "Corruption")
		_G.aurae_UpdateImpSeduce()
	elseif eclass == "PALADIN" then
		_G.aurae_GetSpellRank("Hammer of Justice", "Hammer of Justice")
		if _G.aurae_ConfigBuff ~= nil then
			_G.aurae_GetSpellRank("Divine Shield", "Divine Shield")
		end
	elseif eclass == "HUNTER" then
		_G.aurae_GetSpellRank("Freezing Trap", "Freezing Trap Effect")
		_G.aurae_GetSpellRank("Scare Beast", "Scare Beast")
		_G.aurae_UpdateImpTrap()
	elseif eclass == "PRIEST" then
		_G.aurae_GetSpellRank("Shackle Undead", "Shackle Undead")
		if _G.aurae_ConfigDebuff ~= nil then
			_G.aurae_UpdateImpShadowWordPain()
		end
	elseif eclass == "MAGE" then
		if _G.aurae_ConfigDebuff ~= nil then
			_G.aurae_GetSpellRank("Polymorph", "Polymorph")
			_G.aurae_GetSpellRank("Frostbolt", "Frostbolt")
			_G.aurae_GetSpellRank("Fireball", "Fireball")
			_G.aurae_UpdatePermafrost()
		end
		auraeOptionsFrameArcanist:Show()
		if aurae.ARCANIST then
			aurae.EFFECTS["Polymorph"].DURATION = aurae.EFFECTS["Polymorph"].DURATION + 15
		end
	elseif eclass == "DRUID" then
		_G.aurae_GetSpellRank("Entangling Roots", "Entangling Roots")
		_G.aurae_GetSpellRank("Hibernate", "Hibernate")
		_G.aurae_GetSpellRank("Bash", "Bash")
		_G.aurae_UpdateBrutalImpact()
	end
end

function Help()
	_G.aurae_Print("aurae : Usage - /aurae option")
	_G.aurae_Print("options:")
	_G.aurae_Print(" on     : Enables aurae")
	_G.aurae_Print(" off    : Disables aurae")
	_G.aurae_Print(" lock   : Locks aurae and enables")
	_G.aurae_Print(" unlock : Allows you to move aurae")
	_G.aurae_Print(" u      : Update improved skill ranks")
	_G.aurae_Print(" print  : Prints the current configuration")
	_G.aurae_Print(" invert : Invert progress bar direction")
	_G.aurae_Print(" alpha  : Set bar alpha, use 0 to 1")
	_G.aurae_Print(" config : Show the configuration frame")
end