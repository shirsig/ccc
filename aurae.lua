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
		'PLAYER_TARGET_CHANGED', 'UPDATE_BATTLEFIELD_SCORE',
	} do f:RegisterEvent(event) end
end

CreateFrame('GameTooltip', 'aurae_Tooltip', nil, 'GameTooltipTemplate')

_G.aurae_settings = {}

local WIDTH = 170
local HEIGHT = 16
local MAXBARS = 11

local COMBO = 0

local BARS, timers, pending = {}, {}, {}

function Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage('<aurae> ' .. msg)
end

function CreateBar()
	local texture = [[Interface\Addons\aurae\bar]]
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
		local a = t / bar.fadetime * aurae_settings.alpha
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

		local timer = bar.TIMER

		if timer.stopped then
			if bar:GetAlpha() > 0 then
				bar.spark:Hide()
				bar.fadeelapsed = GetTime() - timer.stopped
				FadeBar(bar)
			end
		else
			bar:SetAlpha(aurae_settings.alpha)
			bar.icon:SetTexture([[Interface\Icons\]] .. (aurae_EFFECTS[timer.EFFECT].ICON or 'INV_Misc_QuestionMark'))
			bar.text:SetText(gsub(timer.UNIT, ':.*', ''))

			local fraction
			if timer.START then
				local duration = timer.END - timer.START
				local remaining = timer.END - GetTime()
				fraction = remaining / duration

				local invert = aurae_settings.invert and not timer.DR
				
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
				r, g, b = 1, 1, .3
			elseif timer.DR == 2 then
				r, g, b = 1, .6, 0
			elseif timer.DR == 3 then
				r, g, b = 1, .3, .3
			else
				r, g, b = .3, 1, .3
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
		f:SetAlpha(aurae_settings.alpha)
		f.statusbar:SetStatusBarColor(1, 1, 1)
		f.statusbar:SetValue(1)
		f.icon:SetTexture[[Interface\Icons\INV_Misc_QuestionMark]]
		f.text:SetText('aurae bar')
		f.timertext:SetText((aurae_settings.growth == 'up' and i or MAXBARS - i + 1))
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
	local factor = {1/2, 1/4, 0}

	function DiminishedDuration(unit, effect, full_duration)
		local class = aurae_DR_CLASS[effect]
		if class and timers[class .. '@' .. unit] then
			return full_duration * factor[timers[class .. '@' .. unit].DR or 1]
		else
			return full_duration
		end
	end
end

function TargetDebuffs()
	local debuffs = {}
	local i = 1
	while UnitDebuff('target', i) do
		aurae_Tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
		aurae_Tooltip:SetUnitDebuff('target', i)
		debuffs[aurae_TooltipTextLeft1:GetText()] = true
		i = i + 1
	end
	return debuffs
end

do
	local casting = {}
	local last_cast

	local function extractRank(str)
		local _, _, rank = strfind(str or '', 'Rank (%d+)')
		return tonumber(rank)
	end

	do
		local orig = UseAction
		function _G.UseAction(slot, clicked, onself)
			if HasAction(slot) and not GetActionText(slot) then
				aurae_Tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
				aurae_TooltipTextRight1:SetText()
				aurae_Tooltip:SetAction(slot)
				local name = aurae_TooltipTextLeft1:GetText()
				casting[name] = {unit=TARGET_ID, rank=extractRank(aurae_TooltipTextRight1:GetText())}
			end
			return orig(slot, clicked, onself)
		end
	end

	do
		local orig = CastSpell
		function _G.CastSpell(index, booktype)
			local name, rankText = GetSpellName(index, booktype)
			casting[name] = {unit=TARGET_ID, rank=extractRank(rankText)}
			return orig(index, booktype)
		end
	end

	do
		local orig = CastSpellByName
		function _G.CastSpellByName(text, onself)
			if not onself then
				local _, _, name, rank = strfind(text, '(.*)%([Rr][Aa][Nn][Kk] (%d+)%)')
				name = name or text
				casting[name] = {unit=TARGET_ID, rank=tonumber(rank)}
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
		for effect, info in casting do
			if pending[effect] then
				last_cast = nil
			elseif aurae_ACTION[effect] then
				local duration = aurae_EFFECTS[effect].DURATION[min(info.rank or 1, getn(aurae_EFFECTS[effect].DURATION))]
				if aurae_COMBO[effect] then
					duration = duration + aurae_COMBO[effect] * COMBO
				end
				if aurae_BONUS[effect] then
					duration = duration + aurae_BONUS[effect]()
				end
				if IsPlayer(info.unit) then
					duration = DiminishedDuration(info.unit, effect, aurae_PVP_DURATION[effect] or duration)
				end
				info.duration = duration
				info.time = GetTime() + (aurae_DELAY[effect] and 1.5 or 0)
				pending[effect] = info
				last_cast = effect
			end
		end
		casting = {}
	end

	function SPELLCAST_INTERRUPTED()
		if last_cast then
			pending[last_cast] = nil
		end
	end
end

CreateFrame'Frame':SetScript('OnUpdate', function()
	for effect, info in pending do
		if GetTime() >= info.time + .5 then
			if TARGET_ID ~= info.unit or TargetDebuffs()[effect] then
				StartTimer(effect, info.unit, info.time, info.duration)
			end
			pending[effect] = nil
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
				pending[effect] = nil
				return
			end
		end
	end
end

function AbortCast(effect, unit)
	for k, v in pending do
		if k == effect and v.unit == unit then
			pending[k] = nil
		end
	end
end

function AbortUnitCasts(unit)
	for k, v in pending do
		if v.unit == unit or not unit and not IsPlayer(v.unit) then
			pending[k] = nil
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
	for k, v in aurae_DR_CLASS do
		if v == aurae_DR_CLASS[effect] and EffectActive(k, unit) then
			return
		end
	end
	local timer = timers[aurae_DR_CLASS[effect] .. '@' .. unit]
	if timer then
		timer.START = GetTime()
		timer.END = timer.START + 15
	end
end

function AuraGone(unit, effect)
	if aurae_EFFECTS[effect] then
		if IsPlayer(unit) then
			AbortCast(effect, unit)
			StopTimer(effect .. '@' .. unit)
			if aurae_DR_CLASS[effect] then
				ActivateDRTimer(effect, unit)
			end
		elseif unit == UnitName'target' then
			-- TODO pet target (in other places too)
			local debuffs = TargetDebuffs()
			for k, timer in timers do
				if timer.UNIT == TARGET_ID and not debuffs[timer.EFFECT] then
					StopTimer(timer.EFFECT .. '@' .. timer.UNIT)
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
	for _, timer in timers do
		if not timer.visible then
			local up = aurae_settings.growth == 'up'
			for i = (up and 1 or MAXBARS), (up and MAXBARS or 1), (up and 1 or -1) do
				if BARS[i].TIMER.stopped then
					BARS[i].TIMER = timer
					timer.visible = true
					break
				end
			end
		end
	end
end

function UpdateTimers()
	local t = GetTime()
	for k, timer in timers do
		if timer.END and t > timer.END then
			StopTimer(k)
			if aurae_DR_CLASS[timer.EFFECT] and not timer.DR then
				ActivateDRTimer(timer.EFFECT, timer.UNIT)
			end
		end
	end
end

function EffectActive(effect, unit)
	return timers[effect .. '@' .. unit] and true or false
end

function StartTimer(effect, unit, start, duration)
	local key = effect .. '@' .. unit
	local timer = timers[key] or {}
	timers[key] = timer

	timer.EFFECT = effect
	timer.UNIT = unit
	timer.START = start
	timer.END = timer.END and max(timer.END, timer.START + duration) or timer.START + duration

	if IsPlayer(unit) and aurae_DR_CLASS[effect] then
		StartDR(effect, unit)
	end

	timer.stopped = nil
	PlaceTimers()
end

function StartDR(effect, unit)

	local key = aurae_DR_CLASS[effect] .. '@' .. unit
	local timer = timers[key] or {}

	if not timer.DR or timer.DR < 3 then
		timers[key] = timer

		timer.EFFECT = effect
		timer.UNIT = unit
		timer.START = nil
		timer.END = nil
		timer.DR = min(3, (timer.DR or 0) + 1)

		PlaceTimers()
	end
end

function PLAYER_REGEN_ENABLED()
	AbortUnitCasts()
	for k, timer in timers do
		if not IsPlayer(timer.UNIT) then
			StopTimer(k)
		end
	end
end

function StopTimer(key)
	if timers[key] then
		timers[key].stopped = GetTime()
		timers[key] = nil
		PlaceTimers()
	end
end

function UnitDied(unit)
	AbortUnitCasts(unit)
	for k, timer in timers do
		if timer.UNIT == unit then
			StopTimer(k)
		end
	end
	PlaceTimers()
end

CreateFrame'Frame':SetScript('OnUpdate', RequestBattlefieldScoreData)

do
	local player = {}

	local function hostilePlayer(msg)
		local _, _, name = strfind(arg1, "^([^%s']*)")
		return name
	end

	function CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS()
		if player[hostilePlayer(arg1)] == nil then player[hostilePlayer(arg1)] = true end -- wrong for pets
		-- TODO gains (blue?)
	end

	local function talentRank(i, j)
		local _, _, _, _, rank = GetTalentInfo(i, j)
		return rank
	end

	local function specialEvents(effect, unit)
		local _, class = UnitClass'player'
		if effect == "Freezing Trap Effect" and class == 'HUNTER' and unit == UnitName'target' then -- TODO recent
			StartTimer(effect, unit, GetTime(), 20 + 20 * talentRank(3, 7) * .15) -- TODO spell rank
		elseif effect == "Seduction" and class == 'WARLOCK' and unit == UnitName'target' then -- TODO pettarget nostbug
			StartTimer(effect, unit, GetTime(), 15 + talentRank(2, 7) * 1.5)
		end
	end

	function CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE()
		if player[hostilePlayer(arg1)] == nil then player[hostilePlayer(arg1)] = true end -- wrong for pets
		for unit, effect in string.gfind(arg1, '(.+) is afflicted by (.+)%.') do
			if pending[effect] and pending[effect].unit == unit then
				StartTimer(effect, unit, GetTime(), pending[effect].duration)
				pending[effect] = nil
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

	function PLAYER_TARGET_CHANGED()
		local unit = UnitName'target'
		TARGET_ID = unit and (UnitIsPlayer'target' and unit or unit .. ':' .. UnitLevel'target' .. ':' .. UnitSex'target') or ''
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
		arcanist = false,
	}

	function ADDON_LOADED()
		if arg1 ~= 'aurae' then return end

		for k, v in defaultSettings do
			if aurae_settings[k] == nil then
				aurae_settings[k] = v
			end
		end
		
		local dummyTimer = {stopped=0}
		local height = HEIGHT * MAXBARS + 4 * (MAXBARS - 1)
		BARS = CreateFrame('Frame', 'aurae', UIParent)
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
			bar:SetAlpha(aurae_settings.alpha)
			local offset = 20 * (i - 1)
			bar:SetPoint('BOTTOMLEFT', 0, offset)
			bar:SetPoint('BOTTOMRIGHT', 0, offset)
			bar.TIMER = dummyTimer
			tinsert(BARS, bar)
		end

		BARS:SetScale(aurae_settings.scale)

		_G.SLASH_AURAE1 = '/aurae'
		SlashCmdList.AURAE = SlashCommandHandler

		LockBars()
	end

	Print('loaded - /aurae')
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
				aurae_settings.invert = not aurae_settings.invert
				Print('Bar inversion ' .. (aurae_settings.invert and 'on.' or 'off.'))
			elseif args[1] == 'growth' and (args[2] == 'up' or args[2] == 'down') then
				aurae_settings.growth = args[2]
				Print('Growth: ' .. args[2])
				if not LOCKED then UnlockBars() end
			elseif strsub(command, 1, 5) == 'scale' then
				local scale = tonumber(strsub(command, 7))
				if scale then
					scale = max(.5, min(3, scale))
					aurae_settings.scale = scale
					BARS:SetScale(scale)
					Print('Scale: ' .. scale)
				else
					Usage()
				end
			elseif strsub(command, 1, 5) == 'alpha' then
				local alpha = tonumber(strsub(command, 7))
				if alpha then
					alpha = max(0, min(1, alpha))
					aurae_settings.alpha = alpha
					if not LOCKED then UnlockBars() end
					Print('Alpha: ' .. alpha)
				else
					Usage()
				end
			elseif command == 'clear' then
				aurae_settings = nil
				LoadVariables()
			elseif command == 'arcanist' then
				aurae_settings.arcanist = not aurae_settings.arcanist
				Print('Arcanist ' .. (aurae_settings.arcanist and 'on.' or 'off.'))
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
	Print("  arcanist")
end