function aurae_ConfigCC()

-- required attributes: GROUP, DURATION, DIMINISHES
--  ETYPE = Effect Type : ETYPE_CC Pure CC(Stun/Root), ETYPE_DEBUFF Debuff(Snare/DoT,...), ETYPE_BUFF Buff
--  GROUP = Bar this CC is placed on
--  DURATION = Duration of CC
--  DIMINISHES = 0 never diminishes, 1 = always diminishes, 2 = diminishes on players only
-- optional attributes PVPCC, COMBO
--  PVPCC = if PVPCC exists this value will be used as the base max for a Player target
--  COMBO = if COMBO exists then Combo Points will be added to CC duration
--
-- TARGET, PLAYER, TIMER_START, TIMER_END, DIMINISH are required for all and should be initialized empty
-- MONITOR is required for all and should be initialized to true
-- WARN is required for all and should be initialized to 0

-- Rogue - Stun/Root CCs
aurae.EFFECTS[aurae_GOUGE] = {
	ICON = 'Ability_Gouge',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 4,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_BLIND] = {
	ICON = 'Spell_Shadow_MindSteal',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_SAP] = {
	ICON = 'Ability_Sap',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 45,
	PVP_DURATION = 15,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_KS] = {
	ICON = 'Ability_Rogue_KidneyShot',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 1,
	COMBO = true,
	A = 1, -- f(x) = A * x + DURATION => 1 point = 2 sec, 5 point = 6 sec
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_CS] = {
	ICON = 'Ability_CheapShot',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 4,
	MONITOR = true,
	WARN = 0,
}

-- Priest - Stun/Root CCs
aurae.EFFECTS[aurae_SHACKLE] = {
	ICON = 'Spell_Nature_Slow',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	DURATION = 30,	-- 40 50
	MONITOR = true,
	WARN = 0,
	DIMINISH = 0
}

aurae.EFFECTS[aurae_PSYCHICSCREAM] = {
	ICON = 'Spell_Shadow_PsychicScream',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 8,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 0
}

aurae.EFFECTS[aurae_BLACKOUT] = {
	ICON = 'Spell_Shadow_GatherShadows',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 2,
	MONITOR = true,
	WARN = 0,
	DIMINISH = 0
}

-- Mage - Stun/Root CCs
aurae.EFFECTS[aurae_POLYMORPH] = {
	ICON = 'Spell_Nature_Polymorph', -- Spell_Magic_PolymorphPig, TODO Ability_Hunter_Pet_Turtle
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_CC,
	DURATION = 20,
	PVP_DURATION = 15,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_FROSTNOVA] = {
	ICON = 'Spell_Frost_FreezingBreath',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_CC,
	DURATION = 8,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_FROSTBITE] = {
	ICON = 'Spell_Frost_FrostArmor',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_CC,
	DURATION = 5,
	MONITOR = true,
	WARN = 0,
}

-- Druid - Stun/Root CCs
aurae.EFFECTS[aurae_ROOTS] = {
	ICON = 'Spell_Nature_StrangleVines',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	DURATION = 12, -- 15 18 21 24 27
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_HIBERNATE] = {
	ICON = 'Spell_Nature_Sleep',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	DURATION = 20, -- 30 40
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_FERALCHARGE] = {
	ICON = 'Ability_Hunter_Pet_Bear',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 4,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_IMPSTARFIRE] = {
	ICON = 'Spell_Arcane_StarFire',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_CC,
	DURATION = 3,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_POUNCE] = {
	ICON = 'Ability_Druid_SupriseAttack',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 2,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_BASH] = {
	ICON = 'Ability_Druid_Bash',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 2, -- 2, 3, 4
	MONITOR = true,
	WARN = 0,
}

-- Hunter - Stun/Root CCs
aurae.EFFECTS[aurae_FREEZINGTRAP] = {
	ICON = 'Spell_Frost_ChainsOfIce',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_CC,
	DURATION = 10, -- 15 20
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_IMPCS] = {
	ICON = 'Spell_Frost_IceShock',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_CC,
	DURATION = 4,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_SCAREBEAST] = {
	ICON = 'Ability_Druid_Cower',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	DURATION = 10, -- 15 20
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_SCATTERSHOT] = {
	ICON = 'Ability_GolemStormBolt',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 4, -- 15 20
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_INTIMIDATION] = {
	ICON = 'Ability_Devour',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 3, -- 15 20
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_COUNTERATTACK] = {
	ICON = 'Ability_Warrior_Challange',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 5,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_IMPROVEDWINGCLIP] = {
	ICON = 'Ability_Rogue_Trip',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 5,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_WYVERNSTING] = {
	ICON = 'INV_Spear_02',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	DURATION = 12,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_ENTRAPMENT] = {
	ICON = 'Spell_Nature_StrangleVines',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 5,
	MONITOR = true,
	WARN = 0,
}

-- Paladin - Stun/Root CCs
aurae.EFFECTS[aurae_HOJ] = {
	ICON = 'Spell_Holy_SealOfMight',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	DURATION = 3, -- 4 5 6
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_REPENTANCE] = {
	ICON = 'Spell_Holy_PrayerOfHealing',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	DURATION = 6,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_TURNUNDEAD] = {
	ICON = 'Spell_Holy_TurnUndead',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	DURATION = 10, -- 15 20
	MONITOR = true,
	WARN = 0,
}

-- Warlock - Stun/Root CCs
aurae.EFFECTS[aurae_SEDUCE] = {
	ICON = 'Spell_Shadow_MindSteal',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_FEAR] = {
	ICON = 'Spell_Shadow_Possession',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 10, -- 15 20
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_HOWLOFTERROR] = {
	ICON = 'Spell_Shadow_DeathScream',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 10, -- 15
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_DEATHCOIL] = {
	ICON = 'Spell_Shadow_DeathCoil',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 3,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_BANISH] = {
	ICON = 'Spell_Shadow_Cripple',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 20, -- 30
	MONITOR = true,
	WARN = 0,
}

-- Warrior - Stun/Root CCs
aurae.EFFECTS[aurae_INTERCEPT] = {
	ICON = 'Ability_Rogue_Sprint',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 3,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_MACESPE] = {
	ICON = 'INV_Mace_01',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 3,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_HAMSTRING] = {
	ICON = 'Ability_ShockWave',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_IMPHAMSTRING] = {
	ICON = 'Ability_ShockWave',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 3,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_INTIMIDATINGSHOUT] = {
	ICON = 'Ability_GolemThunderClap',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 8,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_IMPREVENGE] = {
	ICON = 'Ability_Warrior_Revenge',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 3,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_CONCUSSIONBLOW] = {
	ICON = 'Ability_ThunderBolt',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 5,
	MONITOR = true,
	WARN = 0,
}

-- Specific - Stun/Root CCs

-- Tauren
aurae.EFFECTS[aurae_WARSTOMP] = {
	ICON = 'Ability_WarStomp',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 2,
	MONITOR = true,
	WARN = 0,
}

-- Green Whelp Armour
aurae.EFFECTS[aurae_SLEEP] = {
	ICON = 'Spell_Holy_MindVision',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 30,
	MONITOR = true,
	WARN = 0,
}

-- Net O Matic
aurae.EFFECTS[aurae_NETOMATIC] = {
	ICON = 'INV_Misc_Net_01',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}

-- Reckless Helmet
aurae.EFFECTS[aurae_ROCKETHELM] = {
	ICON = 'INV_Helmet_49',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 30,
	MONITOR = true,
	WARN = 0,
}

end