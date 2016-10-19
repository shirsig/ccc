function aurae_ConfigDebuff()

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

-- Rogue - Debuffs
aurae.EFFECTS[aurae_RUPTURE] = {
	ICON = 'Ability_Rogue_Rupture',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 2,
	COMBO = true,
	A = 4, -- f(x) = A * x + DURATION
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_GAROTTE] = {
	ICON = 'Ability_Rogue_Garrote',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 18,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_RIPOSTE] = {
	ICON = 'Ability_Warrior_Challange',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 6,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_CRIPPLINGP] = {
	ICON = 'Ability_PoisonSting',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_DEADLYP] = {
	ICON = 'Ability_Rogue_DualWeild',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_IMPROVEDKICK] = {
	ICON = 'Ability_Kick',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 2,
	MONITOR = true,
	WARN = 0,
}

-- Priest - Debuffs
aurae.EFFECTS[aurae_SHADOWWORDPAIN] = {
	ICON = 'Spell_Shadow_ShadowWordPain',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 18,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_DEVOURINGPLAGUE] = {
	ICON = 'Spell_Shadow_BlackPlague',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 24,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_WEAKENEDSOUL] = {
	ICON = 'Spell_Holy_AshesToAshes',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_HOLYFIRE] = {
	ICON = 'Spell_Holy_SearingLight',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}

-- Mage - Debuffs

aurae.EFFECTS['Pyroclasm'] = {
	ICON = 'Spell_Fire_Volcano',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 3,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS['Aftermath'] = {
	ICON = 'Spell_Fire_Fire',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 5,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_DETECTMAGIC] = {
	ICON = 'Spell_Holy_Dizzy',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 120,
	MONITOR = false,
	WARN = 0,
}
aurae.EFFECTS[aurae_FROSTBOLT] = {
	ICON = 'Spell_Frost_FrostBolt02',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 5,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_CONEOFCOLD] = {
	ICON = 'Spell_Frost_Glacier',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_COUNTERSPELL] = {
	ICON = 'Spell_Frost_IceShock',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 4,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_FIREBALL] = {
	ICON = 'Spell_Fire_FlameBolt',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 4,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_PYROBLAST] = {
	ICON = 'Spell_Fire_Fireball02',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_IGNITE] = {
	ICON = 'Spell_Fire_Incinerate',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 4,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_FLAMESTRIKE] = {
	ICON = 'Spell_Fire_SelfDestruct',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
	MONITOR = false,
	WARN = 0,
}

aurae.EFFECTS[aurae_BLASTWAVE] = {
	ICON = 'Spell_Holy_Excorcism_02',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 6,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_FROSTARMOR] = {
	ICON = 'Spell_Frost_FrostArmor02',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
	MONITOR = true,
	WARN = 0,
}

-- Druid - Debuffs
aurae.EFFECTS[aurae_FAERIEFIRE] = {
	ICON = 'Spell_Nature_FaerieFire',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 40,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_FAERIEFIREFERAL] = {
	ICON = 'Spell_Nature_FaerieFire',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 40,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_MOONFIRE] = {
	ICON = 'Spell_Nature_StarFall',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
	MONITOR = true,
	WARN = 0,
}

-- Hunter - Debuffs
aurae.EFFECTS[aurae_SERPENTSTING] = {
	ICON = 'Ability_Hunter_Quickshot',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_VIPERSTING] = {
	ICON = 'Ability_Hunter_AimedShot',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
	MONITOR = true,
	WARN = 0,
}

-- Paladin - Debuffs

-- Warlock - Debuffs

aurae.EFFECTS['Shadowburn'] = {
	ICON = 'Spell_Shadow_ScourgeBuild',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 5,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS['Shadow Vulnerability'] = {
	ICON = 'spell_shadow_blackplague',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_IMMOLATE] = {
	ICON = 'Spell_Fire_Immolation',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_CORRUPTION] = {
	ICON = 'Spell_Shadow_AbominationExplosion',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 18,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_CURSEOFAGONY] = {
	ICON = 'Spell_Shadow_CurseOfSargeras',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 24,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_CURSEOFEXHAUSTION] = {
	ICON = 'Spell_Shadow_GrimWard',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_CURSEOFELEMENTS] = {
	ICON = 'Spell_Shadow_ChillTouch',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 300,
	MONITOR = false,
	WARN = 0,
}

aurae.EFFECTS[aurae_CURSEOFSHADOW] = {
	ICON = 'Spell_Shadow_CurseOfAchimonde',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 300,
	MONITOR = false,
	WARN = 0,
}

aurae.EFFECTS[aurae_CURSEOFTONGUES] = {
	ICON = 'Spell_Shadow_CurseOfTounges',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 30,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_CURSEOFWEAKNESS] = {
	ICON = 'Spell_Shadow_CurseOfMannoroth',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 120,
	MONITOR = false,
	WARN = 0,
}

aurae.EFFECTS[aurae_CURSEOFRECKLESSNESS] = {
	ICON = 'Spell_Shadow_UnholyStrength',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 120,
	MONITOR = false,
	WARN = 0,
}

aurae.EFFECTS[aurae_CURSEOFDOOM] = {
	ICON = 'Spell_Shadow_AuraOfDarkness',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 60,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_SIPHONLIFE] = {
	ICON = 'Spell_Shadow_Requiem',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 30,
	MONITOR = false,
	WARN = 0,
}
aurae.EFFECTS[aurae_IMPROVEDSHADOWBOLT] = {
	ICON = 'Spell_Shadow_ShadowBolt',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_SPELLLOCK] = {
	ICON = 'Spell_Shadow_MindRot',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 3,
	MONITOR = true,
	WARN = 0,
}
-- Warrior - Debuffs
aurae.EFFECTS[aurae_DISARM] = {
	ICON = 'Ability_Warrior_Disarm',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_MORTALSTRIKE] = {
	ICON = 'Ability_Warrior_SavageBlow',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 10,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_REND] = {
	ICON = 'Ability_Gouge',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 21,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_HAMSTRING] = {
	ICON = 'Ability_ShockWave',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 15,
	MONITOR = true,
	WARN = 0,
}
-- Shaman - Debuffs

aurae.EFFECTS[aurae_FROSTSHOCK] = {
	ICON = 'Spell_Frost_FrostShock',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
	MONITOR = true,
	WARN = 0,
}

aurae.EFFECTS[aurae_FLAMESHOCK] = {
	ICON = 'Spell_Fire_FlameShock',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_FROSTBRANDWEAPON] = {
	ICON = 'Spell_Frost_FrostBrand',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
	MONITOR = true,
	WARN = 0,
}
aurae.EFFECTS[aurae_STORMSTRIKE] = {
	ICON = 'Spell_Holy_SealOfMight',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
	MONITOR = true,
	WARN = 0,
}

-- Specific - Debuffs

end