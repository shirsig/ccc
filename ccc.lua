local addon_name, addon_table = ...
setfenv(1, setmetatable(addon_table, { __index = _G }))

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
		'CHAT_MSG_COMBAT_HONOR_GAIN',
		'PLAYER_REGEN_ENABLED',
		'PLAYER_TARGET_CHANGED',
	} do f:RegisterEvent(event) end
end

_G.ccc_settings = {}

local WIDTH = 170
local HEIGHT = 16
local MAXBARS = 11

local BARS, TIMERS, EFFECT = {}, {}, {}

local LATEST_TARGET

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
	f.statusbar:SetBackdrop{ bgFile = texture }
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
			bar.icon:SetTexture(timer.texture or [[Interface\Icons\INV_Misc_QuestionMark]])
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
	local factor = { [0] = 1, 1/2, 1/4, 0 }

	function DiminishedDuration(unit, effect, full_duration)
		if IsPlayer(unit) or IsPet(unit) then
			local class = DR_CLASS[effect]
			local timer = class and TIMERS[class .. '@' .. unit]
			local DR = IsPlayer(unit) and timer and timer.DR or 0
			return full_duration * factor[DR]
		else
			return full_duration
		end
	end
end

function TargetDebuffs()
	local debuffs = {}
	local i = 1
	while UnitDebuff('target', i) do
		local debuff_name, _, _, _, _, _, source = UnitDebuff('target', i)
		if source == 'player' then
			debuffs[debuff_name] = true
		end
		i = i + 1
	end
	return debuffs
end

function UNIT_SPELLCAST_SENT(_, _, _, spell)
	if STEALTH[spell] or spell == 1499 or spell == 14310 or spell == 14311 then -- Freezing Trap
		SetEffectDuration(spell)
	end
end

function UNIT_SPELLCAST_SUCCEEDED(_, _, spell)
	SetEffectDuration(spell)
end

function SetEffectDuration(spell)
	local effect = SPELL_EFFECT[spell] or spell

	if not DURATION[effect] then
		return
	end

	local duration = DURATION[effect]
	if COMBO[effect] then
		duration = duration + COMBO[effect] * GetComboPoints('player', 'target')
	end
	if BONUS[effect] then
		duration = duration + BONUS[effect](duration)
	end

	EFFECT[GetSpellInfo(effect)] = { id = effect, duration = duration }
end

function AuraGone(unit, effect_name)
	local key = effect_name .. '@' .. unit
	local timer = TIMERS[key]
	if timer then
		StopTimer(key)
		ActivateDRTimer(timer, unit)
	end
end

function ActivateDRTimer(timer, unit)
	local dr_class = DR_CLASS[timer.effect]
	if dr_class then
		for k, v in pairs(DR_CLASS) do
			if v == dr_class and EffectActive(k, unit) then
				return
			end
		end
		local timer = TIMERS[dr_class .. '@' .. unit]
		if timer then
			timer.start = GetTime()
			timer.expiration = timer.start + 15
		end
	end
end

function CHAT_MSG_COMBAT_HONOR_GAIN(_, _, _, _, player_name)
	UnitDied(player_name)
end

function PLAYER_REGEN_ENABLED()
	for k, timer in pairs(TIMERS) do
		if not IsPlayer(timer.unit) and not IsPet(timer.unit) and not OOC[timer.effect] then
			StopTimer(k)
		end
	end
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
			if not timer.DR then
				ActivateDRTimer(timer, timer.unit)
			end
		end
	end
end

function EffectActive(effect, unit)
	return TIMERS[GetSpellInfo(effect) .. '@' .. unit] and true or false
end

function StartTimer(effect, unit, unit_name, duration, start)
	local effect_name, _, texture = GetSpellInfo(effect)

	if ccc_settings.ignore[effect_name] then
		return
	end

	if ccc_settings.aoe == 'target' and AOE[effect] and unit ~= LATEST_TARGET then
		return
	end

	duration = DiminishedDuration(unit, effect, duration)

	if duration == 0 then
		return
	end

	local key = effect_name .. '@' .. unit
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
	timer.effect_name = effect_name
	timer.unit = unit
	timer.unit_name = unit_name
	timer.start = start or GetTime()
	timer.expiration = timer.start + duration
	timer.texture = texture

	if IsPlayer(unit) then
		StartDR(timer, unit)
	end

	timer.stopped = nil
	PlaceTimers()
end

function StartDR(effect_timer, unit)
	local dr_class = DR_CLASS[effect_timer.effect]
	if dr_class then
		local key = dr_class .. '@' .. unit
		local timer = TIMERS[key] or {}

		if not timer.DR or timer.DR < 3 then
			TIMERS[key] = timer

			timer.effect_name = effect_timer.effect_name
			timer.unit = unit
			timer.unit_name = effect_timer.unit_name
			timer.start = nil
			timer.expiration = nil
			timer.DR = min(3, (timer.DR or 0) + 1)
			timer.texture = effect_timer.texture

			PlaceTimers()
		end
	end
end

function StopTimer(key)
	TIMERS[key].stopped = GetTime()
	TIMERS[key] = nil
	PlaceTimers()
end

function UnitDied(unit) -- TODO retail does aura gone not fire when unit dies?
	for k, timer in pairs(TIMERS) do
		if timer.unit == unit then
			StopTimer(k)
		end
	end
end

function COMBAT_LOG_EVENT_UNFILTERED()
	local _, event, _, source, _, _, _, unit, unit_name, _, _, spell, effect_name = CombatLogGetCurrentEventInfo()

	if event == 'UNIT_DIED' then
		UnitDied(unit)
		return
	end

	if source ~= UnitGUID'player' and source ~= UnitGUID'pet' then
		return
	end

	if event == 'SPELL_AURA_APPLIED' or event == 'SPELL_AURA_REFRESH' then
		local effect_info = EFFECT[effect_name]
		if effect_info then
			StartTimer(effect_info.id, unit, unit_name, effect_info.duration)
			return
		end
		local effect, duration
		if effect_name == GetSpellInfo(6358) then -- Seduction
			effect = 6358
			local _, _, _, _, rank = GetTalentInfo(2, 7)
			duration = 15 * (1 + rank * .1)
		elseif effect_name == GetSpellInfo(11201) then -- Crippling Poison
			effect = 11201
			duration = 12
		elseif effect_name == GetSpellInfo(13810) then -- Frost Trap Aura
			effect = 13810
			duration = 30
		elseif effect_name == GetSpellInfo(15269) then -- Blackout
			effect = 15269
			duration = 3
		elseif effect_name == GetSpellInfo(12360) then -- Impact
			effect = 12360
			duration = 2
		elseif effect_name == GetSpellInfo(18118) then -- Aftermath
			effect = 18118
			duration = 5
		elseif effect_name == GetSpellInfo(12494) then -- Frostbite
			effect = 12494
			duration = 5
		elseif effect_name == GetSpellInfo(19229) then -- Improved Wing Clip
			effect = 19229
			duration = 5
		elseif effect_name == GetSpellInfo(23694) then -- Improved Hamstring
			effect = 23694
			duration = 5
		elseif effect_name == GetSpellInfo(18425) then -- Kick - Silenced
			effect = 18425
			duration = 2
		elseif effect_name == GetSpellInfo(18469) then -- Counterspell - Silenced
			effect = 18469
			duration = 4
		elseif effect_name == GetSpellInfo(18498) then -- Shield Bash - Silenced
			effect = 18498
			duration = 3
		elseif effect_name == GetSpellInfo(5530) then -- Mace Stun Effect
			effect = 5530
			duration = 3
		end
		if effect then
			StartTimer(effect, unit, unit_name, duration)
		end
	elseif event == 'SPELL_AURA_REMOVED' then
		AuraGone(unit, effect_name)
	end
end

do
	local unitType = {}

	function PLAYER_TARGET_CHANGED()
		local target_guid = UnitGUID'target'
		if target_guid then
			LATEST_TARGET = target_guid
			if UnitIsPlayer'target' then
				unitType[target_guid] = 1
			elseif UnitPlayerControlled'target' then
				unitType[target_guid] = 2
			end
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
		aoe = 'target',
		ignore = {},
	}

	function ADDON_LOADED(name)
		if name ~= addon_name then
            return
        end

		for k, v in pairs(defaultSettings) do
			if ccc_settings[k] == nil then
				ccc_settings[k] = v
			end
		end
		
		local dummyTimer = { stopped = 0 }
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
		for token in string.gmatch(str, '%S+') do
			tinsert(tokens, token)
		end
		return tokens
	end

	function SlashCommandHandler(command)
		if command then
			local args = tokenize(command)
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
			elseif args[1] == 'scale' then
				local scale = tonumber(args[2])
				if scale then
					scale = max(.5, min(3, scale))
					ccc_settings.scale = scale
					BARS:SetScale(scale)
					Print('Scale: ' .. scale)
				else
					Usage()
				end
			elseif args[1] == 'alpha' then
				local alpha = tonumber(args[2])
				if alpha then
					alpha = max(0, min(1, alpha))
					ccc_settings.alpha = alpha
					if not LOCKED then UnlockBars() end
					Print('Alpha: ' .. alpha)
				else
					Usage()
				end
			elseif args[1] == 'aoe' and (args[2] == 'target' or args[2] == 'all') then
				ccc_settings.aoe = args[2]
				Print('AOE: ' .. args[2])
				if not LOCKED then UnlockBars() end
			elseif command == 'ignore' then
				for effect_name in pairs(ccc_settings.ignore) do
					Print('Ignored effects:')
					Print('  ' .. effect_name)
				end
			elseif args[1] == 'ignore' then
				local _, _, effect_name = strfind(command, '^%s*ignore%s+(.*)')
				ccc_settings.ignore[effect_name] = not ccc_settings.ignore[effect_name] or nil
				Print('Ignoring "' .. effect_name .. '" ' .. (ccc_settings.ignore[effect_name] and 'on. ' or 'off.'))
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
	Print('  aoe (target | all)')
	Print('  ignore {name}')
	Print('  ignore')
end