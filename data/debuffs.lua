local _G = getfenv(0)
function _G.aurae_ConfigDebuff()

	-- Rogue

	aurae.EFFECTS["Rupture"] = {
		ICON = 'Ability_Rogue_Rupture',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 2,
		COMBO = true,
		A = 4, -- f(x) = A * x + DURATION
		MONITOR = true,
	}

	aurae.EFFECTS["Garrote"] = {
		ICON = 'Ability_Rogue_Garrote',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 18,
		MONITOR = true,
	}

	aurae.EFFECTS["Riposte"] = {
		ICON = 'Ability_Warrior_Challange',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 6,
		MONITOR = true,
	}

	aurae.EFFECTS["Crippling Poison"] = {
		ICON = 'Ability_PoisonSting',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 12,
		MONITOR = true,
	}

	aurae.EFFECTS["Deadly Poison"] = {
		ICON = 'Ability_Rogue_DualWeild',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 12,
		MONITOR = true,
	}

	aurae.EFFECTS["Kick - Silenced"] = {
		ICON = 'Ability_Kick',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 2,
		MONITOR = true,
	}

	-- Priest

	aurae.EFFECTS["Shadow Word: Pain"] = {
		ICON = 'Spell_Shadow_ShadowWordPain',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 18,
		MONITOR = true,
	}

	aurae.EFFECTS["Devouring Plague"] = {
		ICON = 'Spell_Shadow_BlackPlague',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 24,
		MONITOR = true,
	}
	aurae.EFFECTS["Weakened Soul"] = {
		ICON = 'Spell_Holy_AshesToAshes',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Holy Fire"] = {
		ICON = 'Spell_Holy_SearingLight',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 10,
		MONITOR = true,
	}

	-- Mage

	aurae.EFFECTS['Pyroclasm'] = {
		ICON = 'Spell_Fire_Volcano',
		SCHOOL = _G.aurae_SCHOOL.FIRE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 3,
		MONITOR = true,
	}

	aurae.EFFECTS['Aftermath'] = {
		ICON = 'Spell_Fire_Fire',
		SCHOOL = _G.aurae_SCHOOL.FIRE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 5,
		MONITOR = true,
	}

	aurae.EFFECTS["Detect Magic"] = {
		ICON = 'Spell_Holy_Dizzy',
		SCHOOL = _G.aurae_SCHOOL.ARCANE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 120,
		MONITOR = false,
	}
	aurae.EFFECTS["Frostbolt"] = {
		ICON = 'Spell_Frost_FrostBolt02',
		SCHOOL = _G.aurae_SCHOOL.FROST,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 5,
		MONITOR = true,
	}

	aurae.EFFECTS["Cone of Cold"] = {
		ICON = 'Spell_Frost_Glacier',
		SCHOOL = _G.aurae_SCHOOL.FROST,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 8,
		MONITOR = true,
	}

	aurae.EFFECTS["Counterspell - Silenced"] = {
		ICON = 'Spell_Frost_IceShock',
		SCHOOL = _G.aurae_SCHOOL.ARCANE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 4,
		MONITOR = true,
	}

	aurae.EFFECTS["Fireball"] = {
		ICON = 'Spell_Fire_FlameBolt',
		SCHOOL = _G.aurae_SCHOOL.FIRE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 4,
		MONITOR = true,
	}

	aurae.EFFECTS["Pyroblast"] = {
		ICON = 'Spell_Fire_Fireball02',
		SCHOOL = _G.aurae_SCHOOL.FIRE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 12,
		MONITOR = true,
	}

	aurae.EFFECTS["Ignite"] = {
		ICON = 'Spell_Fire_Incinerate',
		SCHOOL = _G.aurae_SCHOOL.FIRE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 4,
		MONITOR = true,
	}

	aurae.EFFECTS["Flamestrike"] = {
		ICON = 'Spell_Fire_SelfDestruct',
		SCHOOL = _G.aurae_SCHOOL.FIRE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 8,
		MONITOR = false,
	}

	aurae.EFFECTS["Blast Wave"] = {
		ICON = 'Spell_Holy_Excorcism_02',
		SCHOOL = _G.aurae_SCHOOL.FIRE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 6,
		MONITOR = true,
	}

	aurae.EFFECTS["Chilled"] = {
		ICON = 'Spell_Frost_FrostArmor02',
		SCHOOL = _G.aurae_SCHOOL.FROST,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 8,
		MONITOR = true,
	}

	-- Druid

	aurae.EFFECTS["Faerie Fire"] = {
		ICON = 'Spell_Nature_FaerieFire',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 40,
		MONITOR = true,
	}
	aurae.EFFECTS["Faerie Fire (Feral)"] = {
		ICON = 'Spell_Nature_FaerieFire',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 40,
		MONITOR = true,
	}
	aurae.EFFECTS["Moonfire"] = {
		ICON = 'Spell_Nature_StarFall',
		SCHOOL = _G.aurae_SCHOOL.ARCANE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 8,
		MONITOR = true,
	}

	-- Hunter

	aurae.EFFECTS["Serpent Sting"] = {
		ICON = 'Ability_Hunter_Quickshot',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS["Viper Sting"] = {
		ICON = 'Ability_Hunter_AimedShot',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 8,
		MONITOR = true,
	}

	-- Paladin

	-- Warlock

	aurae.EFFECTS['Shadowburn'] = {
		ICON = 'Spell_Shadow_ScourgeBuild',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 5,
		MONITOR = true,
	}

	aurae.EFFECTS['Shadow Vulnerability'] = {
		ICON = 'spell_shadow_blackplague',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS["Immolate"] = {
		ICON = 'Spell_Fire_Immolation',
		SCHOOL = _G.aurae_SCHOOL.FIRE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS["Corruption"] = {
		ICON = 'Spell_Shadow_AbominationExplosion',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 18,
		MONITOR = true,
	}

	aurae.EFFECTS["Curse of Agony"] = {
		ICON = 'Spell_Shadow_CurseOfSargeras',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 24,
		MONITOR = true,
	}

	aurae.EFFECTS["Curse of Exhaustion"] = {
		ICON = 'Spell_Shadow_GrimWard',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 12,
		MONITOR = true,
	}

	aurae.EFFECTS["Curse of the Elements"] = {
		ICON = 'Spell_Shadow_ChillTouch',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 300,
		MONITOR = false,
	}

	aurae.EFFECTS["Curse of Shadow"] = {
		ICON = 'Spell_Shadow_CurseOfAchimonde',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 300,
		MONITOR = false,
	}

	aurae.EFFECTS["Curse of Tongues"] = {
		ICON = 'Spell_Shadow_CurseOfTounges',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 30,
		MONITOR = true,
	}

	aurae.EFFECTS["Curse of Weakness"] = {
		ICON = 'Spell_Shadow_CurseOfMannoroth',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 120,
		MONITOR = false,
	}

	aurae.EFFECTS["Curse of Recklessness"] = {
		ICON = 'Spell_Shadow_UnholyStrength',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 120,
		MONITOR = false,
	}

	aurae.EFFECTS["Curse of Doom"] = {
		ICON = 'Spell_Shadow_AuraOfDarkness',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 60,
		MONITOR = true,
	}
	aurae.EFFECTS["Siphon Life"] = {
		ICON = 'Spell_Shadow_Requiem',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 30,
		MONITOR = false,
	}
	aurae.EFFECTS["Improved Shadow Bolt"] = {
		ICON = 'Spell_Shadow_ShadowBolt',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 12,
		MONITOR = true,
	}

	aurae.EFFECTS["Spell Lock"] = {
		ICON = 'Spell_Shadow_MindRot',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 3,
		MONITOR = true,
	}
	-- Warrior - Debuffs
	aurae.EFFECTS["Disarm"] = {
		ICON = 'Ability_Warrior_Disarm',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 10,
		MONITOR = true,
	}
	aurae.EFFECTS["Mortal Strike"] = {
		ICON = 'Ability_Warrior_SavageBlow',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 10,
		MONITOR = true,
	}
	aurae.EFFECTS["Rend"] = {
		ICON = 'Ability_Gouge',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 21,
		MONITOR = true,
	}
	aurae.EFFECTS["Hamstring"] = {
		ICON = 'Ability_ShockWave',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Piercing Howl"] = {
		ICON = 'Spell_Shadow_DeathScream',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 6,
		MONITOR = true,
	}

	-- Shaman

	aurae.EFFECTS["Frost Shock"] = {
		ICON = 'Spell_Frost_FrostShock',
		SCHOOL = _G.aurae_SCHOOL.FROST,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 8,
		MONITOR = true,
	}

	aurae.EFFECTS["Flame Shock"] = {
		ICON = 'Spell_Fire_FlameShock',
		SCHOOL = _G.aurae_SCHOOL.FIRE,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 12,
		MONITOR = true,
	}
	aurae.EFFECTS["Frostbrand Weapon"] = {
		ICON = 'Spell_Frost_FrostBrand',
		SCHOOL = _G.aurae_SCHOOL.FROST,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 8,
		MONITOR = true,
	}
	aurae.EFFECTS["Stormstrike"] = {
		ICON = 'Spell_Holy_SealOfMight',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_DEBUFF,
		DURATION = 12,
		MONITOR = true,
	}

	-- Misc
end