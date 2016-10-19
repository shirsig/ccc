function aurae_ConfigBuff()

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

-- Rogue - Target Buffs
aurae.EFFECTS[aurae_ADRENALINERUSH] = {
	ICON = 'Spell_Shadow_ShadowWordDominate',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_ROGUESPRINT] = {
	ICON = 'Ability_Rogue_Sprint',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_EVASION] = {
	ICON = 'Spell_Shadow_ShadowWard',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_BLADEFLURRY] = {
	ICON = 'Ability_GhoulFrenzy',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
-- Priest - Buffs
aurae.EFFECTS[aurae_POWERWORDSHIELD] = {
	ICON = 'Spell_Holy_PowerWordShield',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_BUFF,
	DURATION = 30,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_RENEW] = {
	ICON = 'Spell_Holy_Renew',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_POWERINFUSION] = {
	ICON = 'Spell_Holy_PowerInfusion',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}

-- Mage - Buffs
aurae.EFFECTS[aurae_ARCANEPOWER] = {
	ICON = 'Spell_Nature_Lightning',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_EVOCATION] = {
	ICON = 'Spell_Nature_Purge',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_BUFF,
	DURATION = 8,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_ICEBLOCK] = {
	ICON = 'Spell_Frost_Frost',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_BUFF,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}

-- Druid - Buffs
aurae.EFFECTS[aurae_NATURESGRASP] = {
	ICON = 'Spell_Nature_NaturesWrath',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_BUFF,
	DURATION = 45,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_REJUVENATION] = {
	ICON = 'Spell_Nature_Rejuvenation',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_BUFF,
	DURATION = 12,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_REGROWTH] = {
	ICON = 'Spell_Nature_ResistNature',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_BUFF,
	DURATION = 21,
	MONITOR = false,
	WARN = 0,
}
aurae.EFFECTS[aurae_DASH] = {
	ICON = 'Ability_Druid_Dash',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_INNERVATE] = {
	ICON = 'Spell_Nature_Lightning',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_BUFF,
	DURATION = 20,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_BARKSKIN] = {
	ICON = 'Spell_Nature_StoneClawTotem',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_FREGEN] = {
	ICON = 'Ability_BullRush',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}

-- Hunter - Buffs
aurae.EFFECTS[aurae_DETERRENCE] = {
	ICON = 'Ability_Whirlwind',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_RAPIDFIRE] = {
	ICON = 'Ability_Hunter_RunningShot',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
-- Paladin - Buffs
aurae.EFFECTS[aurae_DIVINESHIELD] = {
	ICON = 'Spell_Holy_DivineIntervention',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_BUFF,
	DURATION = 12,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_BOPROTECTION] = {
	ICON = 'Spell_Holy_SealOfProtection',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_BUFF,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_BOFREEDOM] = {
	ICON = 'Spell_Holy_SealOfValor',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_BUFF,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}

-- Warlock - Buffs
aurae.EFFECTS[aurae_SACRIFICE] = {
	ICON = 'Spell_Shadow_SacrificialShield',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_BUFF,
	DURATION = 30,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_SPELLSTONE] = {
	ICON = 'INV_Misc_Gem_Sapphire_01',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_BUFF,
	DURATION = 45,
	MONITOR = true,
	WARN = 0,
}
-- Warrior - Buffs
aurae.EFFECTS[aurae_BERSERKERRAGE] = {
	ICON = 'Spell_Nature_AncestralGuardian',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_BLOODRAGE] = {
	ICON = 'Ability_Racial_BloodRage',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 10,
	MONITOR = false,
	WARN = 0,
}
aurae.EFFECTS[aurae_LASTSTAND] = {
	ICON = 'Spell_Holy_AshesToAshes',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 20,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_RETALIATION] = {
	ICON = 'Ability_Warrior_Challange',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_SHIELDWALL] = {
	ICON = 'Ability_Warrior_ShieldWall',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_RECKLESSNESS] = {
	ICON = 'Ability_CriticalStrike',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_DEATHWISH] = {
	ICON = 'Spell_Shadow_DeathPact',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 30,
	MONITOR = true,
	WARN = 0,
}
-- Specific - Buffs

-- Forsaken
aurae.EFFECTS[aurae_WOTF] = {
	ICON = 'Spell_Shadow_RaiseDead',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 5,
	MONITOR = true,
	WARN = 0,
}

-- Human
aurae.EFFECTS[aurae_PERCEPTION] = {
	ICON = 'Spell_Nature_Sleep',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_BUFF,
	DURATION = 20,
	MONITOR = true,
	WARN = 0,
}

end