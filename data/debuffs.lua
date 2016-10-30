function aurae_ConfigDebuff()

-- Rogue

aurae.EFFECTS["Rupture"] = {
	ICON = 'Ability_Rogue_Rupture',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 2,
	COMBO = true,
	A = 4, -- f(x) = A * x + DURATION
}

aurae.EFFECTS["Garrote"] = {
	ICON = 'Ability_Rogue_Garrote',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 18,
}

aurae.EFFECTS["Riposte"] = {
	ICON = 'Ability_Warrior_Challange',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 6,
}

aurae.EFFECTS["Crippling Poison"] = {
	ICON = 'Ability_PoisonSting',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
}

aurae.EFFECTS["Deadly Poison"] = {
	ICON = 'Ability_Rogue_DualWeild',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
}

aurae.EFFECTS["Kick - Silenced"] = {
	ICON = 'Ability_Kick',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 2,
}

-- Priest

aurae.EFFECTS["Shadow Word: Pain"] = {
	ICON = 'Spell_Shadow_ShadowWordPain',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 18,
}

aurae.EFFECTS["Devouring Plague"] = {
	ICON = 'Spell_Shadow_BlackPlague',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 24,
}

aurae.EFFECTS["Vampiric Embrace"] = {
	ICON = 'Spell_Shadow_UnsummonBuilding',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 60,
}

aurae.EFFECTS["Weakened Soul"] = {
	ICON = 'Spell_Holy_AshesToAshes',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 15,
}

aurae.EFFECTS["Holy Fire"] = {
	ICON = 'Spell_Holy_SearingLight',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 10,
}

-- Mage

aurae.EFFECTS['Pyroclasm'] = {
	ICON = 'Spell_Fire_Volcano',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 3,
}

aurae.EFFECTS['Aftermath'] = {
	ICON = 'Spell_Fire_Fire',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 5,
}

aurae.EFFECTS["Detect Magic"] = {
	ICON = 'Spell_Holy_Dizzy',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 120,
}

aurae.EFFECTS["Frostbolt"] = {
	ICON = 'Spell_Frost_FrostBolt02',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 5,
}

aurae.EFFECTS["Cone of Cold"] = {
	ICON = 'Spell_Frost_Glacier',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
}

aurae.EFFECTS["Counterspell - Silenced"] = {
	ICON = 'Spell_Frost_IceShock',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 4,
}

aurae.EFFECTS["Fireball"] = {
	ICON = 'Spell_Fire_FlameBolt',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 4,
}

aurae.EFFECTS["Pyroblast"] = {
	ICON = 'Spell_Fire_Fireball02',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
}

aurae.EFFECTS["Ignite"] = {
	ICON = 'Spell_Fire_Incinerate',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 4,
}

aurae.EFFECTS["Flamestrike"] = {
	ICON = 'Spell_Fire_SelfDestruct',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
}

aurae.EFFECTS["Blast Wave"] = {
	ICON = 'Spell_Holy_Excorcism_02',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 6,
}

aurae.EFFECTS["Chilled"] = {
	ICON = 'Spell_Frost_FrostArmor02',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
}

-- Druid

aurae.EFFECTS["Faerie Fire"] = {
	ICON = 'Spell_Nature_FaerieFire',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 40,
}

aurae.EFFECTS["Faerie Fire (Feral)"] = {
	ICON = 'Spell_Nature_FaerieFire',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 40,
}

aurae.EFFECTS["Moonfire"] = {
	ICON = 'Spell_Nature_StarFall',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
}

-- Hunter

aurae.EFFECTS["Serpent Sting"] = {
	ICON = 'Ability_Hunter_Quickshot',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 15,
}

aurae.EFFECTS["Viper Sting"] = {
	ICON = 'Ability_Hunter_AimedShot',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
}

-- Paladin

-- Warlock

aurae.EFFECTS['Shadowburn'] = {
	ICON = 'Spell_Shadow_ScourgeBuild',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 5,
}

aurae.EFFECTS['Shadow Vulnerability'] = {
	ICON = 'spell_shadow_blackplague',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 15,
}

aurae.EFFECTS["Immolate"] = {
	ICON = 'Spell_Fire_Immolation',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 15,
}

aurae.EFFECTS["Corruption"] = {
	ICON = 'Spell_Shadow_AbominationExplosion',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 18,
}

aurae.EFFECTS["Curse of Agony"] = {
	ICON = 'Spell_Shadow_CurseOfSargeras',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 24,
}

aurae.EFFECTS["Curse of Exhaustion"] = {
	ICON = 'Spell_Shadow_GrimWard',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
}

aurae.EFFECTS["Curse of the Elements"] = {
	ICON = 'Spell_Shadow_ChillTouch',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 300,
}

aurae.EFFECTS["Curse of Shadow"] = {
	ICON = 'Spell_Shadow_CurseOfAchimonde',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 300,
}

aurae.EFFECTS["Curse of Tongues"] = {
	ICON = 'Spell_Shadow_CurseOfTounges',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 30,
}

aurae.EFFECTS["Curse of Weakness"] = {
	ICON = 'Spell_Shadow_CurseOfMannoroth',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 120,
}

aurae.EFFECTS["Curse of Recklessness"] = {
	ICON = 'Spell_Shadow_UnholyStrength',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 120,
}

aurae.EFFECTS["Curse of Doom"] = {
	ICON = 'Spell_Shadow_AuraOfDarkness',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 60,
}

aurae.EFFECTS["Siphon Life"] = {
	ICON = 'Spell_Shadow_Requiem',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 30,
}

aurae.EFFECTS["Improved Shadow Bolt"] = {
	ICON = 'Spell_Shadow_ShadowBolt',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
}

aurae.EFFECTS["Spell Lock"] = {
	ICON = 'Spell_Shadow_MindRot',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 3,
}

-- Warrior - Debuffs

aurae.EFFECTS["Disarm"] = {
	ICON = 'Ability_Warrior_Disarm',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 10,
}

aurae.EFFECTS["Mortal Strike"] = {
	ICON = 'Ability_Warrior_SavageBlow',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 10,
}

aurae.EFFECTS["Rend"] = {
	ICON = 'Ability_Gouge',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 21,
}

aurae.EFFECTS["Hamstring"] = {
	ICON = 'Ability_ShockWave',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 15,
}

aurae.EFFECTS["Piercing Howl"] = {
	ICON = 'Spell_Shadow_DeathScream',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 6,
}

-- Shaman

aurae.EFFECTS["Frost Shock"] = {
	ICON = 'Spell_Frost_FrostShock',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
}

aurae.EFFECTS["Flame Shock"] = {
	ICON = 'Spell_Fire_FlameShock',
	SCHOOL = aurae_SCHOOL.FIRE,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
}

aurae.EFFECTS["Frostbrand Weapon"] = {
	ICON = 'Spell_Frost_FrostBrand',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 8,
}

aurae.EFFECTS["Stormstrike"] = {
	ICON = 'Spell_Holy_SealOfMight',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_DEBUFF,
	DURATION = 12,
}

-- Misc

end