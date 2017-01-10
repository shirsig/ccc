local _G, _M = getfenv(0), {}
setfenv(1, setmetatable(_M, {__index=_G}))

do
	local f = CreateFrame'Frame'
	f:SetScript('OnEvent', function()
		_M[event](this)
	end)
	for _, event in {
		'ADDON_LOADED',
		'UNIT_COMBAT',
		'CHAT_MSG_COMBAT_HONOR_GAIN', 'CHAT_MSG_COMBAT_HOSTILE_DEATH', 'PLAYER_REGEN_ENABLED',
		'CHAT_MSG_SPELL_AURA_GONE_OTHER', 'CHAT_MSG_SPELL_BREAK_AURA',
		'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS', 'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE', 'CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE',
		'SPELLCAST_STOP', 'SPELLCAST_INTERRUPTED', 'CHAT_MSG_SPELL_SELF_DAMAGE', 'CHAT_MSG_SPELL_FAILED_LOCALPLAYER',
		'UNIT_AURA', 'PLAYER_TARGET_CHANGED', 'UPDATE_BATTLEFIELD_SCORE',
	} do f:RegisterEvent(event) end
end

CreateFrame('GameTooltip', 'ccwatch_Tooltip', nil, 'GameTooltipTemplate')

_G.ccwatch_settings = {}

local WIDTH = 170
local HEIGHT = 16
local MAXBARS = 11

local COMBO = 0

local BARS, TIMERS, PENDING = {}, {}, {}

function Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage('<ccwatch> ' .. msg)
end

function CreateBar()
	local texture = [[Interface\Addons\ccwatch\bar]]
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
		local a = t / bar.fadetime * ccwatch_settings.alpha
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
			bar:SetAlpha(ccwatch_settings.alpha)
			bar.icon:SetTexture([[Interface\Icons\]] .. (ccwatch_EFFECTS[timer.effect].ICON or 'INV_Misc_QuestionMark'))
			bar.text:SetText(gsub(timer.unit, ':.*', ''))

			local fraction
			if timer.start then
				local duration = timer.expiration - timer.start
				local remaining = timer.expiration - GetTime()
				fraction = remaining / duration

				local invert = ccwatch_settings.invert and not timer.DR
				
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
	BARS:EnableMouse(1)
	for i = 1, MAXBARS do
		local f = BARS[i]
		f:SetAlpha(ccwatch_settings.alpha)
		f.statusbar:SetStatusBarColor(1, 1, 1)
		f.statusbar:SetValue(1)
		f.icon:SetTexture[[Interface\Icons\INV_Misc_QuestionMark]]
		f.text:SetText('ccwatch bar')
		f.timertext:SetText((ccwatch_settings.growth == 'up' and i or MAXBARS - i + 1))
		f.spark:Hide()
	end
end

function LockBars()
	LOCKED = true
	BARS:EnableMouse(0)
	for i = 1, MAXBARS do
		BARS[i]:SetAlpha(0)
	end
end

do
	local factor = {[0] = 1, 1/2, 1/4, 0}
	local limit = {[0] = 15, 10, 5, 0}

	function DiminishedDuration(unit, effect, full_duration)
		local class = ccwatch_DR_CLASS[effect]
		local timer = class and TIMERS[class .. '@' .. unit]
		local DR = timer and timer.DR or 0
		return ccwatch_HEARTBEAT[effect] and min(limit[DR], full_duration * factor[DR]) or full_duration * factor[DR]
	end
end

function TargetDebuffs()
	local debuffs = {}
	local i = 1
	while UnitDebuff('target', i) do
		ccwatch_Tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
		ccwatch_Tooltip:SetUnitDebuff('target', i)
		debuffs[ccwatch_TooltipTextLeft1:GetText()] = true
		i = i + 1
	end
	return debuffs
end

do
	local action, last_action

	local function startAction(name, rank)
		if not action and TARGET_ID then
			action = {name=name, rank=rank, unit=TARGET_ID}
		end
	end

	local function extractRank(str)
		local _, _, rank = strfind(str or '', 'Rank (%d+)')
		return tonumber(rank)
	end

	do
		local orig = UseAction
		function _G.UseAction(slot, clicked, onself) -- TODO onself bug?
			if HasAction(slot) and not GetActionText(slot) then
				ccwatch_Tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
				ccwatch_TooltipTextRight1:SetText()
				ccwatch_Tooltip:SetAction(slot)
				startAction(ccwatch_TooltipTextLeft1:GetText(), extractRank(ccwatch_TooltipTextRight1:GetText()))
			end
			return orig(slot, clicked, onself)
		end
	end

	do
		local orig = CastSpell
		function _G.CastSpell(index, booktype)
			local name, rankText = GetSpellName(index, booktype)
			startAction(name, extractRank(rankText))
			return orig(index, booktype)
		end
	end

	do
		local orig = CastSpellByName
		function _G.CastSpellByName(text, onself)
			if not onself then
				local _, _, name, rank = strfind(text, '(.*)%([Rr][Aa][Nn][Kk] ([1-9]%d*)%)')
				startAction(name or text, tonumber(rank))
			end
			return orig(text, onself)
		end
	end

	function CHAT_MSG_SPELL_FAILED_LOCALPLAYER()
		for name in string.gfind(arg1, 'You fail to %a+ (.*):.*') do
			if action and name == action.name then
				action = nil
			end
		end
	end

	function SPELLCAST_STOP()
		if action then
			if PENDING[action.name] then
				last_action = nil
			elseif ccwatch_ACTION[action.name] then
				action.combo = COMBO
				action.time = GetTime() + (ccwatch_PROJECTILE[action.name] and 1.5 or 0)
				PENDING[action.name] = action
				last_action = action.name
			end
		end
		action = nil
	end

	function SPELLCAST_INTERRUPTED()
		if last_action then
			PENDING[last_action] = nil
		end
	end
end

CreateFrame'Frame':SetScript('OnUpdate', function()
	for effect, info in PENDING do
		if GetTime() >= info.time + .5 then
			if TARGET_ID ~= info.unit or TargetDebuffs()[effect] then
				StartTimer(effect, info.unit, info.time, info.rank, info.combo)
			end
			PENDING[effect] = nil
		end
	end
end)

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
				PENDING[effect] = nil
				return
			end
		end
	end
end

function AbortCast(effect, unit)
	for k, v in PENDING do
		if k == effect and v.unit == unit then
			PENDING[k] = nil
		end
	end
end

function AbortUnitCasts(unit)
	for k, v in PENDING do
		if v.unit == unit or not unit and not IsPlayer(v.unit) then
			PENDING[k] = nil
		end
	end
end

function CHAT_MSG_SPELL_AURA_GONE_OTHER()
	for effect, unit in string.gfind(arg1, '(.+) fades from (.+)%.') do
		AuraGone(unit, effect)
	end
end

function CHAT_MSG_SPELL_BREAK_AURA()
	for unit, effect in string.gfind(arg1, "(.+)'s (.+) is removed%.") do
		AuraGone(unit, effect)
	end
end

function ActivateDRTimer(effect, unit)
	for k, v in ccwatch_DR_CLASS do
		if v == ccwatch_DR_CLASS[effect] and EffectActive(k, unit) then
			return
		end
	end
	local timer = TIMERS[ccwatch_DR_CLASS[effect] .. '@' .. unit]
	if timer then
		timer.start = GetTime()
		timer.expiration = timer.start + 15
	end
end

function AuraGone(unit, effect)
	if ccwatch_EFFECTS[effect] then
		if IsPlayer(unit) then
			AbortCast(effect, unit)
			StopTimer(effect .. '@' .. unit)
			if ccwatch_DR_CLASS[effect] then
				ActivateDRTimer(effect, unit)
			end
		elseif unit == UnitName'target' then
			-- TODO pet target (in other places too)
			local debuffs = TargetDebuffs()
			for k, timer in TIMERS do
				if timer.unit == TARGET_ID and not debuffs[timer.effect] then
					StopTimer(timer.effect .. '@' .. timer.unit)
				end
			end
		end
	end
end

function CHAT_MSG_COMBAT_HOSTILE_DEATH()
	for unit in string.gfind(arg1, '(.+) dies') do -- TODO does not work when xp is gained
		if IsPlayer(unit) then
			UnitDied(unit)
		elseif unit == UnitName'target' and UnitIsDead'target' then
			UnitDied(TARGET_ID)
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
		COMBO = GetComboPoints()
	end
end

function PlaceTimers()
	for _, timer in TIMERS do
		if not timer.visible then
			local up = ccwatch_settings.growth == 'up'
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
	for k, timer in TIMERS do
		if timer.expiration and t > timer.expiration then
			StopTimer(k)
			if ccwatch_DR_CLASS[timer.effect] and not timer.DR then
				ActivateDRTimer(timer.effect, timer.unit)
			end
		end
	end
end

function EffectActive(effect, unit)
	return TIMERS[effect .. '@' .. unit] and true or false
end

function StartTimer(effect, unit, start, rank, combo)

	local duration = ccwatch_EFFECTS[effect].DURATION[min(rank or 1, getn(ccwatch_EFFECTS[effect].DURATION))]
	if ccwatch_COMBO[effect] then
		duration = duration + ccwatch_COMBO[effect] * combo
	end
	if ccwatch_BONUS[effect] then
		duration = duration + ccwatch_BONUS[effect]()
	end
	if IsPlayer(unit) then
		duration = DiminishedDuration(unit, effect, duration)
	end

	if duration == 0 then
		return
	end

	local key = effect .. '@' .. unit
	local timer = TIMERS[key] or {}

	if ccwatch_UNIQUENESS_CLASS[effect] then
		for k, v in TIMERS do
			if not v.DR and ccwatch_UNIQUENESS_CLASS[v.effect] == ccwatch_UNIQUENESS_CLASS[effect] then
				StopTimer(k)
			end
		end
	end

	TIMERS[key] = timer

	timer.effect = effect
	timer.unit = unit
	timer.start = start
	timer.expiration = timer.start + duration

	if IsPlayer(unit) and ccwatch_DR_CLASS[effect] then
		StartDR(effect, unit)
	end

	timer.stopped = nil
	PlaceTimers()
end

function StartDR(effect, unit)

	local key = ccwatch_DR_CLASS[effect] .. '@' .. unit
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

function PLAYER_REGEN_ENABLED()
	AbortUnitCasts()
	for k, timer in TIMERS do
		if not IsPlayer(timer.unit) then
			StopTimer(k)
		end
	end
end

function StopTimer(key)
	if TIMERS[key] then
		TIMERS[key].stopped = GetTime()
		TIMERS[key] = nil
		PlaceTimers()
	end
end

function UnitDied(unit)
	AbortUnitCasts(unit)
	for k, timer in TIMERS do
		if timer.unit == unit then
			StopTimer(k)
		end
	end
end

CreateFrame'Frame':SetScript('OnUpdate', RequestBattlefieldScoreData)

do
	local player = {}
	local targetEffects

	local function hostilePlayer(msg)
		local _, _, name = strfind(arg1, "^([^%s']*)")
		return name
	end

	function CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS()
		if player[hostilePlayer(arg1)] == nil then player[hostilePlayer(arg1)] = true end -- wrong for pets
		-- TODO gains?
	end

	local function specialEvents(effect, unit)
		local _, class = UnitClass'player'
		if effect == "Freezing Trap Effect" and class == 'HUNTER' and unit == UnitName'target' then -- TODO recent
			StartTimer(effect, unit, GetTime(), 3) -- TODO spell rank
		elseif effect == "Seduction" and class == 'WARLOCK' and unit == UnitName'target' then -- TODO pettarget nostbug
			StartTimer(effect, unit, GetTime())
		end
	end

	function CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE()
		if player[hostilePlayer(arg1)] == nil then player[hostilePlayer(arg1)] = true end -- wrong for pets
		for unit, effect in string.gfind(arg1, '(.+) is afflicted by (.+)%.') do
			if PENDING[effect] and PENDING[effect].unit == unit then
				StartTimer(effect, unit, GetTime(), PENDING[effect].rank)
				PENDING[effect] = nil
			else
				specialEvents(effect, unit)
			end
		end
	end

	function CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE()
		for unit, effect in string.gfind(arg1, '(.+) is afflicted by (.+)%.') do
			specialEvents(effect, unit)
		end
	end

	function UNIT_AURA()
		if arg1 ~= 'target' then return end
		local effects = TargetDebuffs()
		for effect in effects do
			if not targetEffects[effect] and PENDING[effect] and PENDING[effect].unit == TARGET_ID then
				StartTimer(effect, TARGET_ID, GetTime(), PENDING[effect].rank)
				PENDING[effect] = nil
			-- else
			-- 	specialEvents(effect, unit)
			end
		end
		targetEffects = effects
	end

	function PLAYER_TARGET_CHANGED()
		targetEffects = TargetDebuffs()
		local unit = UnitName'target'
		TARGET_ID = unit and (UnitIsPlayer'target' and unit or unit .. ':' .. UnitLevel'target' .. ':' .. UnitSex'target')
		if unit then
			player[unit] = UnitIsPlayer'target' and true or false
		end
	end

	function UPDATE_BATTLEFIELD_SCORE()
		for i = 1, GetNumBattlefieldScores() do
			player[GetBattlefieldScore(i)] = true
		end
	end

	function IsPlayer(unit)
		return player[unit]
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

	function ADDON_LOADED()
		if arg1 ~= 'ccwatch' then return end

		for k, v in defaultSettings do
			if ccwatch_settings[k] == nil then
				ccwatch_settings[k] = v
			end
		end
		
		local dummyTimer = {stopped=0}
		local height = HEIGHT * MAXBARS + 4 * (MAXBARS - 1)
		BARS = CreateFrame('Frame', 'ccwatch', UIParent)
		BARS:SetWidth(WIDTH + HEIGHT)
		BARS:SetHeight(height)
		BARS:SetMovable(true)
		BARS:SetUserPlaced(true)
		BARS:SetClampedToScreen(true)
		BARS:RegisterForDrag('LeftButton')
		BARS:SetScript('OnDragStart', function()
			this:StartMoving()
		end)
		BARS:SetScript('OnDragStop', function()
			this:StopMovingOrSizing()
		end)
		BARS:SetPoint('CENTER', 0, 150)
		for i = 1, MAXBARS do
			local bar = CreateBar()
			bar:SetParent(BARS)
			bar:SetAlpha(ccwatch_settings.alpha)
			local offset = 20 * (i - 1)
			bar:SetPoint('BOTTOMLEFT', 0, offset)
			bar:SetPoint('BOTTOMRIGHT', 0, offset)
			bar.timer = dummyTimer
			tinsert(BARS, bar)
		end

		BARS:SetScale(ccwatch_settings.scale)

		_G.SLASH_CCWATCH1 = '/ccwatch'
		SlashCmdList.CCWATCH = SlashCommandHandler

		LockBars()
	end

	Print('loaded - /ccwatch')
end

do
	local function tokenize(str)
		local tokens = {}
		for token in string.gfind(str, '%S+') do tinsert(tokens, token) end
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
				ccwatch_settings.invert = not ccwatch_settings.invert
				Print('Bar inversion ' .. (ccwatch_settings.invert and 'on.' or 'off.'))
			elseif args[1] == 'growth' and (args[2] == 'up' or args[2] == 'down') then
				ccwatch_settings.growth = args[2]
				Print('Growth: ' .. args[2])
				if not LOCKED then UnlockBars() end
			elseif strsub(command, 1, 5) == 'scale' then
				local scale = tonumber(strsub(command, 7))
				if scale then
					scale = max(.5, min(3, scale))
					ccwatch_settings.scale = scale
					BARS:SetScale(scale)
					Print('Scale: ' .. scale)
				else
					Usage()
				end
			elseif strsub(command, 1, 5) == 'alpha' then
				local alpha = tonumber(strsub(command, 7))
				if alpha then
					alpha = max(0, min(1, alpha))
					ccwatch_settings.alpha = alpha
					if not LOCKED then UnlockBars() end
					Print('Alpha: ' .. alpha)
				else
					Usage()
				end
			elseif command == 'clear' then
				ccwatch_settings = nil
				LoadVariables()
			else
				Usage()
			end
		end
	end
end

function Usage()
	Print("Usage:")
	Print("  lock | unlock")
	Print("  invert")
	Print("  growth (up | down)")
	Print("  scale [0.5,3]")
	Print("  alpha [0,1]")
end