setfenv(1, setmetatable(select(2, ...), {__index=_G}))

do
	local f = CreateFrame'Frame'
	f:SetScript('OnEvent', function(self, event, ...)
		getfenv(1)[event](...)
	end)
	for _, event in pairs{
		'ADDON_LOADED',
		'UNIT_SPELLCAST_SENT',
		'UNIT_SPELLCAST_SUCCEEDED',
		'COMBAT_LOG_EVENT_UNFILTERED',
		'UNIT_AURA',
		'CHAT_MSG_COMBAT_HONOR_GAIN',
		'PLAYER_REGEN_ENABLED',
		'PLAYER_TARGET_CHANGED',
	} do f:RegisterEvent(event) end
end

_G.ccc_settings = {}

local WIDTH = 170
local HEIGHT = 16
local MAXBARS = 11

local DELAY = 1

local BARS, TIMERS, PENDING, CASTS = {}, {}, {}, {}
local TARGET_GUID, TARGET_DEBUFFS

local FREEZING_TRAP_RANK

function Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage('<ccc> ' .. msg)
end

function CreateBar()
	local texture = [[Interface\Addons\ccc\bar]]
	local font, _, style = GameFontHighlight:GetFont()
	local fontsize = 11

	local f = CreateFrame('Frame', nil, UIParent)

	f.fadetime = .5

	f:SetHeight(HEIGHT)

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
	f.text:SetText''

	f.timertext = f.statusbar:CreateFontString(nil, 'OVERLAY')
--	f.text:SetFontObject(GameFontHighlightSmallOutline)
	f.timertext:SetFontObject(GameFontHighlight)
	f.timertext:SetFont(font, fontsize, style)
	f.timertext:SetPoint('TOPLEFT', 2, 0)
	f.timertext:SetPoint('BOTTOMRIGHT', -2, 0)
	f.timertext:SetJustifyH'RIGHT'
	f.timertext:SetText''

	return f
end

function FadeBar(bar)
	if bar.fadeelapsed > bar.fadetime then
		bar:SetAlpha(0)
	else
		local t = bar.fadetime - bar.fadeelapsed
		local a = t / bar.fadetime * ccc_settings.alpha
		bar:SetAlpha(a)
	end
end

function UpdateBars()
	for i = 1, MAXBARS do
		UpdateBar(BARS[i])
	end
end

do
	local function formatTime(t)
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

	function UpdateBar(bar)
		if not LOCKED then
			return
		end

		local timer = bar.timer

		if timer.stopped then
			if bar:GetAlpha() > 0 then
				bar.spark:Hide()
				bar.fadeelapsed = GetTime() - timer.stopped
				FadeBar(bar)
			end
		else
			bar:SetAlpha(ccc_settings.alpha)
			bar.icon:SetTexture([[Interface\Icons\]] .. (ICON[timer.effect] or 'INV_Misc_QuestionMark'))
			bar.text:SetText(timer.unit_name)

			local fraction
			if timer.start then
				local duration = timer.expiration - timer.start
				local remaining = timer.expiration - GetTime()
				fraction = remaining / duration

				local invert = ccc_settings.invert and not timer.DR
				
				bar.statusbar:SetValue( invert and 1 - fraction or fraction)

				local sparkPosition = WIDTH * fraction
				bar.spark:Show()
				bar.spark:SetPoint('CENTER', bar.statusbar, invert and 'RIGHT' or 'LEFT', invert and -sparkPosition or sparkPosition, 0)

				bar.timertext:SetText(formatTime(remaining))
			else
				fraction = 1
				bar.statusbar:SetValue(1)
				bar.spark:Hide()
				bar.timertext:SetText()
			end
			local r, g, b
			if timer.DR == 1 then
				r, g, b = .9, .9, .3
			elseif timer.DR == 2 then
				r, g, b = .9, .6, 0
			elseif timer.DR == 3 then
				r, g, b = .9, .3, .3
			else
				r, g, b = .3, .9, .3
			end
			bar.statusbar:SetStatusBarColor(r, g, b)
			bar.statusbar:SetBackdropColor(r, g, b, .3)
		end
	end
end

function UnlockBars()
	LOCKED = false
	BARS:EnableMouse(true)
	for i = 1, MAXBARS do
		local f = BARS[i]
		f:SetAlpha(ccc_settings.alpha)
		f.statusbar:SetStatusBarColor(1, 1, 1)
		f.statusbar:SetValue(1)
		f.icon:SetTexture[[Interface\Icons\INV_Misc_QuestionMark]]
		f.text:SetText('ccc bar')
		f.timertext:SetText((ccc_settings.growth == 'up' and i or MAXBARS - i + 1))
		f.spark:Hide()
	end
end

function LockBars()
	LOCKED = true
	BARS:EnableMouse(false)
	for i = 1, MAXBARS do
		BARS[i]:SetAlpha(0)
	end
end

do
	local factor = {[0] = 1, 1/2, 1/4, 0}
	local limit = {[0] = 15, 10, 5, 0}

	function DiminishedDuration(unit, effect, full_duration)
		if IsPlayer(unit) or IsPet(unit) then
			local class = DR_CLASS[effect]
			local timer = class and TIMERS[class .. '@' .. unit]
			local DR = IsPlayer(unit) and timer and timer.DR or 0
			return HEARTBEAT[effect] and min(limit[DR], full_duration * factor[DR]) or full_duration * factor[DR]
		else
			return full_duration
		end
	end
end

function TargetDebuffs()
	local debuffs = {}
	local i = 1
	while UnitDebuff('target', i) do
		local debuff, _, _, _, _, _, source = UnitDebuff('target', i)
		if source == 'player' then
			debuffs[debuff] = true
		end
		i = i + 1
	end
	return debuffs
end

do
	function UNIT_SPELLCAST_SENT(_, _, cast_guid)
		CASTS[cast_guid] = { target = TARGET_GUID, target_name = UnitName'target' }
	end

	function UNIT_SPELLCAST_SUCCEEDED(unit, cast_guid, spell)
		-- TODO only fires for unit player in classic?
		local name = strlower(GetSpellInfo(spell))

		if not ACTION[name] then
			return
		end
		local _, _, rank = strfind(GetSpellSubtext(spell) or '', 'Rank ([1-9]%d*)')
		if name == 'freezing trap' then
			FREEZING_TRAP_RANK = rank
		end
		local duration = ACTION[name].duration[min(rank or 1, getn(ACTION[name].duration))]
		if COMBO[name] then
			duration = duration + COMBO[name] * GetComboPoints()
		end
		if BONUS[name] then
			duration = duration + BONUS[name]()
		end
		local cast = CASTS[cast_guid]
		tinsert(PENDING, {
			name = name,
			rank = rank,
			unit = cast.target,
			unit_name = cast.target_name,
			time = GetTime() + (PROJECTILE[name] and 1.5 or 0),
			effect = GetSpellInfo(spell), -- TODO sometimes effect has different name
			duration = duration,
			targetChanged = cast.targetChanged,
		})
		CASTS = {} -- TODO does this not break anything?
	end
end

CreateFrame'Frame':SetScript('OnUpdate', function()
	for i = getn(PENDING), 1, -1 do
		if GetTime() >= PENDING[i].time + DELAY then
			if not AOE[PENDING[i].name] and (PENDING[i].targetChanged or TARGET_DEBUFFS[PENDING[i].effect]) then -- TODO do we need targetChanged or is the combat log range large enough
				StartTimer(PENDING[i].effect, PENDING[i].unit, PENDING[i].unit_name, PENDING[i].duration, PENDING[i].time)
			end
			tremove(PENDING, i)
		end
	end
end)

function AbortCast(effect, unit)
	for i = getn(PENDING), 1, -1 do
		if PENDING[i].effect == effect and PENDING[i].unit == unit then
			tremove(PENDING, i)
		end
	end
end

function AuraGone(unit, effect)
	-- AbortCast(effect, unit) TODO retail
	StopTimer(effect .. '@' .. unit)
	if DR_CLASS[effect] then
		ActivateDRTimer(effect, unit)
	end
end

function ActivateDRTimer(effect, unit)
	for k, v in pairs(DR_CLASS) do
		if v == DR_CLASS[effect] and EffectActive(k, unit) then
			return
		end
	end
	local timer = TIMERS[DR_CLASS[effect] .. '@' .. unit]
	if timer then
		timer.start = GetTime()
		timer.expiration = timer.start + 15
	end
end

function CHAT_MSG_COMBAT_HONOR_GAIN(...) -- TODO retail is this needed?
	-- for unit in string.gmatch(arg1, '(.+) dies') do
	-- 	UnitDied(unit)
	-- end
end

function PLAYER_REGEN_ENABLED(...) -- TODO retail is this needed (combat log range)
	-- for i = getn(PENDING), 1, -1 do
	-- 	if not IsPlayer(PENDING[i].unit) and not IsPet(PENDING[i].unit) then
	-- 		tremove(PENDING, i)
	-- 	end
	-- end
	-- for k, timer in pairs(TIMERS) do
	-- 	if not IsPlayer(timer.unit) and not IsPet(timer.unit) then
	-- 		StopTimer(k)
	-- 	end
	-- end
end

function PlaceTimers()
	for _, timer in pairs(TIMERS) do
		if not timer.visible then
			local up = ccc_settings.growth == 'up'
			for i = (up and 1 or MAXBARS), (up and MAXBARS or 1), (up and 1 or -1) do
				if BARS[i].timer.stopped then
					BARS[i].timer = timer
					timer.visible = true
					break
				end
			end
		end
	end
end

function UpdateTimers()
	local t = GetTime()
	for k, timer in pairs(TIMERS) do
		if timer.expiration and t > timer.expiration then
			StopTimer(k)
			if DR_CLASS[timer.effect] and not timer.DR then
				ActivateDRTimer(timer.effect, timer.unit)
			end
		end
	end
end

function EffectActive(effect, unit)
	return TIMERS[effect .. '@' .. unit] and true or false
end

function StartTimer(effect, unit, unit_name, duration, start)
	duration = DiminishedDuration(unit, effect, duration)

	if duration == 0 then
		return
	end

	local key = effect .. '@' .. unit
	local timer = TIMERS[key] or {}

	if UNIQUENESS_CLASS[effect] then
		for k, v in pairs(TIMERS) do
			if not v.DR and UNIQUENESS_CLASS[v.effect] == UNIQUENESS_CLASS[effect] then
				StopTimer(k)
			end
		end
	end

	TIMERS[key] = timer

	timer.effect = effect
	timer.unit = unit
	timer.unit_name = unit_name
	timer.start = start or GetTime()
	timer.expiration = timer.start + duration

	if IsPlayer(unit) and DR_CLASS[effect] then
		StartDR(effect, unit)
	end

	timer.stopped = nil
	PlaceTimers()
end

function StartDR(effect, unit)

	local key = DR_CLASS[effect] .. '@' .. unit
	local timer = TIMERS[key] or {}

	if not timer.DR or timer.DR < 3 then
		TIMERS[key] = timer

		timer.effect = effect
		timer.unit = unit
		timer.start = nil
		timer.expiration = nil
		timer.DR = min(3, (timer.DR or 0) + 1)

		PlaceTimers()
	end
end

function StopTimer(key)
	if TIMERS[key] then
		TIMERS[key].stopped = GetTime()
		TIMERS[key] = nil
		PlaceTimers()
	end
end

function UnitDied(unit) -- TODO retail does aura gone not fire when unit dies?
	for i = getn(PENDING), 1, -1 do
		if PENDING[i].unit == unit then
			tremove(PENDING, i)
		end
	end
	for k, timer in pairs(TIMERS) do
		if timer.unit == unit then
			StopTimer(k)
		end
	end
end

function COMBAT_LOG_EVENT_UNFILTERED()
	local _, event, _, source_guid, _, _, _, guid, name, _, _, _, effect = CombatLogGetCurrentEventInfo()

	if event == 'UNIT_DIED' then
		UnitDied(guid)
	end

	if source_guid ~= UnitGUID'player' then
		return
	end

	if event == 'SPELL_AURA_APPLIED' then
		for i = 1, getn(PENDING) do
			if PENDING[i].effect == effect and PENDING[i].unit == guid then
				StartTimer(effect, guid, name, PENDING[i].duration)
				tremove(PENDING, i)
				break
			end
		end
		local duration
		if effect == "Freezing Trap Effect" and FREEZING_TRAP_RANK then
			local _, _, _, _, rank = GetTalentInfo(3, 7)
			duration = (5 + 5 * FREEZING_TRAP_RANK) * (1 + rank * .15)
		elseif effect == "Seduction" then
			local _, _, _, _, rank = GetTalentInfo(2, 7)
			duration = 15 * (1 + rank * .1)
		elseif effect == "Crippling Poison" then
			duration = 12
		elseif effect == "Blackout" then
			duration = 3
		elseif effect == "Impact" then
			duration = 2
		elseif effect == "Aftermath" then
			duration = 5
		end
		if duration then
			StartTimer(effect, guid, name, duration)
		end
	elseif event == 'SPELL_AURA_REMOVED' then
		AuraGone(guid, effect)
	elseif event == 'SPELL_MISSED' then
		for i = 1, getn(PENDING) do
			if PENDING[i].effect == effect and PENDING[i].unit == guid then
				tremove(PENDING, i)
				break
			end
		end
	end
end

function UNIT_AURA(unit)
	if unit ~= 'target' then return end
	local effects = TargetDebuffs()
	for effect in pairs(TARGET_DEBUFFS) do
		if not effects[effect] then
			AuraGone(TARGET_GUID, effect)
		end
	end
	for effect in pairs(effects) do
		if not TARGET_DEBUFFS[effect] or TARGET_DEBUFFS[effect] ~= effects[effect] then
			for i = 1, getn(PENDING) do
				if PENDING[i].effect == effect and (PENDING[i].unit == TARGET_GUID or AOE[PENDING[i].name]) then
					StartTimer(effect, TARGET_GUID, PENDING[i].unit_name, PENDING[i].duration)
					tremove(PENDING, i)
					break
				end
			end
		end
	end
	TARGET_DEBUFFS = effects
end

do
	local unitType = {}

	function PLAYER_TARGET_CHANGED()
		TARGET_DEBUFFS = TargetDebuffs()
		TARGET_GUID = UnitGUID'target'
		if TARGET_GUID then
			if UnitIsPlayer'target' then
				unitType[TARGET_GUID] = 1
			elseif UnitPlayerControlled'target' then
				unitType[TARGET_GUID] = 2
			end
		end
		for _, cast in pairs(CASTS) do
			cast.targetChanged = true
		end
		for _, action in pairs(PENDING) do
			action.targetChanged = true
		end
	end

	function IsPlayer(guid)
		return unitType[guid] == 1
	end

	function IsPet(guid)
		return unitType[guid] == 2
	end
end

CreateFrame'Frame':SetScript('OnUpdate', function()
	UpdateTimers()
	if not LOCKED then
		return
	end
	UpdateBars()
end)

do
	local defaultSettings = {
		invert = false,
		growth = 'up',
		scale = 1,
		alpha = .85,
	}

	function ADDON_LOADED(arg1)
		if arg1 ~= 'ccc' then return end

		for k, v in pairs(defaultSettings) do
			if ccc_settings[k] == nil then
				ccc_settings[k] = v
			end
		end
		
		local dummyTimer = {stopped=0}
		local height = HEIGHT * MAXBARS + 4 * (MAXBARS - 1)
		BARS = CreateFrame('Frame', 'ccc', UIParent)
		BARS:SetWidth(WIDTH + HEIGHT)
		BARS:SetHeight(height)
		BARS:SetMovable(true)
		BARS:SetUserPlaced(true)
		BARS:SetClampedToScreen(true)
		BARS:SetScript('OnMouseDown', function(self)
			self:StartMoving()
		end)
		BARS:SetScript('OnMouseUp', function(self)
			self:StopMovingOrSizing()
		end)
		BARS:SetPoint('CENTER', 0, 150)
		for i = 1, MAXBARS do
			local bar = CreateBar()
			bar:SetParent(BARS)
			bar:SetAlpha(ccc_settings.alpha)
			local offset = 20 * (i - 1)
			bar:SetPoint('BOTTOMLEFT', 0, offset)
			bar:SetPoint('BOTTOMRIGHT', 0, offset)
			bar.timer = dummyTimer
			tinsert(BARS, bar)
		end

		BARS:SetScale(ccc_settings.scale)

		_G.SLASH_CCC1 = '/ccc'
		SlashCmdList.CCC = SlashCommandHandler

		LockBars()
	end

	Print('loaded - /ccc')
end

do
	local function tokenize(str)
		local tokens = {}
		for token in string.gmatch(str, '%S+') do tinsert(tokens, token) end
		return tokens
	end

	function SlashCommandHandler(msg)
		if msg then
			local args = tokenize(msg)
			local command = strlower(msg)
			if command == 'unlock' then
				UnlockBars()
				Print('Bars unlocked.')
			elseif command == 'lock' then
				LockBars()
				Print('Bars locked.')
			elseif command == 'invert' then
				ccc_settings.invert = not ccc_settings.invert
				Print('Bar inversion ' .. (ccc_settings.invert and 'on.' or 'off.'))
			elseif args[1] == 'growth' and (args[2] == 'up' or args[2] == 'down') then
				ccc_settings.growth = args[2]
				Print('Growth: ' .. args[2])
				if not LOCKED then UnlockBars() end
			elseif strsub(command, 1, 5) == 'scale' then
				local scale = tonumber(strsub(command, 7))
				if scale then
					scale = max(.5, min(3, scale))
					ccc_settings.scale = scale
					BARS:SetScale(scale)
					Print('Scale: ' .. scale)
				else
					Usage()
				end
			elseif strsub(command, 1, 5) == 'alpha' then
				local alpha = tonumber(strsub(command, 7))
				if alpha then
					alpha = max(0, min(1, alpha))
					ccc_settings.alpha = alpha
					if not LOCKED then UnlockBars() end
					Print('Alpha: ' .. alpha)
				else
					Usage()
				end
			elseif command == 'clear' then
				ccc_settings = nil
				LoadVariables()
			else
				Usage()
			end
		end
	end
end

function Usage()
	Print('Usage:')
	Print('  lock | unlock')
	Print('  invert')
	Print('  growth (up | down)')
	Print('  scale [0.5,3]')
	Print('  alpha [0,1]')
end