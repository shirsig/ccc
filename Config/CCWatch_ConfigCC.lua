function CCWatch_ConfigCC()

-- required attributes: GROUP, LENGTH, DIMINISHES
--  ETYPE = Effect Type : ETYPE_CC Pure CC(Stun/Root), ETYPE_DEBUFF Debuff(Snare/DoT,...), ETYPE_BUFF Buff
--  GROUP = Bar this CC is placed on
--  LENGTH = Duration of CC
--  DIMINISHES = 0 never diminishes, 1 = always diminishes, 2 = diminishes on players only
-- optional attributes PVPCC, COMBO
--  PVPCC = if PVPCC exists this value will be used as the base max for a Player target
--  COMBO = if COMBO exists then Combo Points will be added to CC duration
--
-- TARGET, PLAYER, TIMER_START, TIMER_END, DIMINISH are required for all and should be initialized empty
-- MONITOR is required for all and should be initialized to true
-- WARN is required for all and should be initialized to 0

-- Rogue - Stun/Root CCs
CCWATCH.CCS[CCWATCH_GOUGE] = {
	ICON = 'Ability_Gouge',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	GROUP = 1,
	ETYPE = ETYPE_CC,
	LENGTH = 4,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_BLIND] = {
	ICON = 'Spell_Shadow_MindSteal',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 10,
	DIMINISHES = 1,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_SAP] = {
	ICON = 'Ability_Sap',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 45,
	PVPCC = 15,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_KS] = {
	ICON = 'Ability_Rogue_KidneyShot',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 1,
	DIMINISHES = 1,
	COMBO = true,
	A = 1, -- f(x) = A * x + LENGTH => 1 point = 2 sec, 5 point = 6 sec
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_CS] = {
	ICON = 'Ability_CheapShot',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 4,
	DIMINISHES = 1,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

-- Priest - Stun/Root CCs
CCWATCH.CCS[CCWATCH_SHACKLE] = {
	ICON = 'Spell_Nature_Slow',
	SCHOOL = CCWATCH_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 30,	-- 40 50
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 0
}

CCWATCH.CCS[CCWATCH_PSYCHICSCREAM] = {
	ICON = 'Spell_Shadow_PsychicScream',
	SCHOOL = CCWATCH_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 8,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 0
}

CCWATCH.CCS[CCWATCH_BLACKOUT] = {
	ICON = 'Spell_Shadow_GatherShadows',
	SCHOOL = CCWATCH_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 2,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 0
}

-- Mage - Stun/Root CCs
CCWATCH.CCS[CCWATCH_POLYMORPH] = {
	ICON = 'Spell_Nature_Polymorph', -- Spell_Magic_PolymorphPig, TODO Ability_Hunter_Pet_Turtle
	SCHOOL = CCWATCH_SCHOOL.ARCANE,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 20, -- 30 40 50
	PVPCC = 15,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_FROSTNOVA] = {
	ICON = 'Spell_Frost_FreezingBreath',
	SCHOOL = CCWATCH_SCHOOL.FROST,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 8,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_FROSTBITE] = {
	ICON = 'Spell_Frost_FrostArmor',
	SCHOOL = CCWATCH_SCHOOL.FROST,
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 5,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_ICEBLOCK] = {
	ICON = 'Spell_Frost_Frost',
	SCHOOL = CCWATCH_SCHOOL.FROST,
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 10,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}


-- Druid - Stun/Root CCs
CCWATCH.CCS[CCWATCH_ROOTS] = {
	ICON = 'Spell_Nature_StrangleVines',
	SCHOOL = CCWATCH_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 12, -- 15 18 21 24 27
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_HIBERNATE] = {
	ICON = 'Spell_Nature_Sleep',
	SCHOOL = CCWATCH_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 20, -- 30 40
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_FERALCHARGE] = {
	ICON = 'Ability_Hunter_Pet_Bear',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 4,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_IMPSTARFIRE] = {
	ICON = 'Spell_Arcane_StarFire',
	SCHOOL = CCWATCH_SCHOOL.ARCANE,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 3,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_POUNCE] = {
	ICON = 'Ability_Druid_SupriseAttack',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 2,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_BASH] = {
	ICON = 'Ability_Druid_Bash',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 2, -- 2, 3, 4
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

-- Hunter - Stun/Root CCs
CCWATCH.CCS[CCWATCH_FREEZINGTRAP] = {
	ICON = 'Spell_Frost_ChainsOfIce',
	SCHOOL = CCWATCH_SCHOOL.FROST,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 10, -- 15 20
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_IMPCS] = {
	ICON = 'Spell_Frost_IceShock',
	SCHOOL = CCWATCH_SCHOOL.ARCANE,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 4,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_SCAREBEAST] = {
	ICON = 'Ability_Druid_Cower',
	SCHOOL = CCWATCH_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 10, -- 15 20
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_SCATTERSHOT] = {
	ICON = 'Ability_GolemStormBolt',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 4, -- 15 20
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_INTIMIDATION] = {
	ICON = 'Ability_Devour',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 3, -- 15 20
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_COUNTERATTACK] = {
	ICON = 'Ability_Warrior_Challange',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 5,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_IMPROVEDWINGCLIP] = {
	ICON = 'Ability_Rogue_Trip',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 5,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_WYVERNSTING] = {
	ICON = 'INV_Spear_02',
	SCHOOL = CCWATCH_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 12,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_ENTRAPMENT] = {
	ICON = 'Spell_Nature_StrangleVines',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 5,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

-- Paladin - Stun/Root CCs
CCWATCH.CCS[CCWATCH_HOJ] = {
	ICON = 'Spell_Holy_SealOfMight',
	SCHOOL = CCWATCH_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 3, -- 4 5 6
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_REPENTANCE] = {
	ICON = 'Spell_Holy_PrayerOfHealing',
	SCHOOL = CCWATCH_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 6,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_TURNUNDEAD] = {
	ICON = 'Spell_Holy_TurnUndead',
	SCHOOL = CCWATCH_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 10, -- 15 20
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

-- Warlock - Stun/Root CCs
CCWATCH.CCS[CCWATCH_SEDUCE] = {
	ICON = 'Spell_Shadow_MindSteal',
	SCHOOL = CCWATCH_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 15,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_FEAR] = {
	ICON = 'Spell_Shadow_Possession',
	SCHOOL = CCWATCH_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 10, -- 15 20 
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_HOWLOFTERROR] = {
	ICON = 'Spell_Shadow_DeathScream',
	SCHOOL = CCWATCH_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 10, -- 15
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_DEATHCOIL] = {
	ICON = 'Spell_Shadow_DeathCoil',
	SCHOOL = CCWATCH_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 3,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_BANISH] = {
	ICON = 'Spell_Shadow_Cripple',
	SCHOOL = CCWATCH_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 20, -- 30
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

-- Warrior - Stun/Root CCs
CCWATCH.CCS[CCWATCH_INTERCEPT] = {
	ICON = 'Ability_Rogue_Sprint',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 3,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_MACESPE] = {
	ICON = 'INV_Mace_01',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 3,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_HAMSTRING] = {
	ICON = 'Ability_ShockWave',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_IMPHAMSTRING] = {
	ICON = 'Ability_ShockWave',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 3,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_INTIMIDATINGSHOUT] = {
	ICON = 'Ability_GolemThunderClap',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 8,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_IMPREVENGE] = {
	ICON = 'Ability_Warrior_Revenge',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 3,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

CCWATCH.CCS[CCWATCH_CONCUSSIONBLOW] = {
	ICON = 'Ability_ThunderBolt',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 5,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

-- Specific - Stun/Root CCs

-- Tauren
CCWATCH.CCS[CCWATCH_WARSTOMP] = {
	ICON = 'Ability_WarStomp',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 2,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

-- Green Whelp Armour
CCWATCH.CCS[CCWATCH_SLEEP] = {
	ICON = 'Spell_Holy_MindVision',
	SCHOOL = CCWATCH_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 30,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

-- Net O Matic
CCWATCH.CCS[CCWATCH_NETOMATIC] = {
	ICON = 'INV_Misc_Net_01',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 10,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

-- Reckless Helmet
CCWATCH.CCS[CCWATCH_ROCKETHELM] = {
	ICON = 'INV_Helmet_49',
	SCHOOL = CCWATCH_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 30,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 1,
}

end