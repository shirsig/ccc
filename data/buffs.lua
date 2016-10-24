function aurae_ConfigBuff()

	-- Rogue

	aurae.EFFECTS["Adrenaline Rush"] = {
		ICON = 'Spell_Shadow_ShadowWordDominate',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Sprint"] = {
		ICON = 'Ability_Rogue_Sprint',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Evasion"] = {
		ICON = 'Spell_Shadow_ShadowWard',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Blade Flurry"] = {
		ICON = 'Ability_GhoulFrenzy',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}

	-- Priest

	aurae.EFFECTS["Shadow Word: Shield"] = {
		ICON = 'Spell_Holy_PowerWordShield',
		SCHOOL = aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 30,
		MONITOR = true,
	}
	aurae.EFFECTS["Renew"] = {
		ICON = 'Spell_Holy_Renew',
		SCHOOL = aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS["Power Infusion"] = {
		ICON = 'Spell_Holy_PowerInfusion',
		SCHOOL = aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}

	-- Mage

	aurae.EFFECTS["Arcane Power"] = {
		ICON = 'Spell_Nature_Lightning',
		SCHOOL = aurae_SCHOOL.ARCANE,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS["Evocation"] = {
		ICON = 'Spell_Nature_Purge',
		SCHOOL = aurae_SCHOOL.ARCANE,
		ETYPE = ETYPE_BUFF,
		DURATION = 8,
		MONITOR = true,
	}

	aurae.EFFECTS["Ice Block"] = {
		ICON = 'Spell_Frost_Frost',
		SCHOOL = aurae_SCHOOL.FROST,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}

	-- Druid

	aurae.EFFECTS["Nature's Grasp"] = {
		ICON = 'Spell_Nature_NaturesWrath',
		SCHOOL = aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_BUFF,
		DURATION = 45,
		MONITOR = true,
	}
	aurae.EFFECTS["Rejuvenation"] = {
		ICON = 'Spell_Nature_Rejuvenation',
		SCHOOL = aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_BUFF,
		DURATION = 12,
		MONITOR = true,
	}
	aurae.EFFECTS["Regrowth"] = {
		ICON = 'Spell_Nature_ResistNature',
		SCHOOL = aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_BUFF,
		DURATION = 21,
		MONITOR = false,
	}
	aurae.EFFECTS["Dash"] = {
		ICON = 'Ability_Druid_Dash',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Innervate"] = {
		ICON = 'Spell_Nature_Lightning',
		SCHOOL = aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_BUFF,
		DURATION = 20,
		MONITOR = true,
	}
	aurae.EFFECTS["Barkskin"] = {
		ICON = 'Spell_Nature_StoneClawTotem',
		SCHOOL = aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Frenzied Regeneration"] = {
		ICON = 'Ability_BullRush',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}

	-- Hunter

	aurae.EFFECTS["Deterrence"] = {
		ICON = 'Ability_Whirlwind',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}
	aurae.EFFECTS["Rapid Fire"] = {
		ICON = 'Ability_Hunter_RunningShot',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}

	-- Paladin

	aurae.EFFECTS["Divine Shield"] = {
		ICON = 'Spell_Holy_DivineIntervention',
		SCHOOL = aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 12,
		MONITOR = true,
	}
	aurae.EFFECTS["Blessing of Protection"] = {
		ICON = 'Spell_Holy_SealOfProtection',
		SCHOOL = aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}
	aurae.EFFECTS["Blessing of Freedom"] = {
		ICON = 'Spell_Holy_SealOfValor',
		SCHOOL = aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}

	-- Warlock

	aurae.EFFECTS["Sacrifice"] = {
		ICON = 'Spell_Shadow_SacrificialShield',
		SCHOOL = aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_BUFF,
		DURATION = 30,
		MONITOR = true,
	}
	aurae.EFFECTS["Spellstone"] = {
		ICON = 'INV_Misc_Gem_Sapphire_01',
		SCHOOL = aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_BUFF,
		DURATION = 45,
		MONITOR = true,
	}

	-- Warrior

	aurae.EFFECTS["Berserker Rage"] = {
		ICON = 'Spell_Nature_AncestralGuardian',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}
	aurae.EFFECTS["Bloodrage"] = {
		ICON = 'Ability_Racial_BloodRage',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = false,
	}
	aurae.EFFECTS["Last Stand"] = {
		ICON = 'Spell_Holy_AshesToAshes',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 20,
		MONITOR = true,
	}
	aurae.EFFECTS["Retaliation"] = {
		ICON = 'Ability_Warrior_Challange',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Shield Wall"] = {
		ICON = 'Ability_Warrior_ShieldWall',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}
	aurae.EFFECTS["Recklessness"] = {
		ICON = 'Ability_CriticalStrike',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Death Wish"] = {
		ICON = 'Spell_Shadow_DeathPact',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 30,
		MONITOR = true,
	}

	-- Misc

	aurae.EFFECTS["Will of the Forsaken"] = {
		ICON = 'Spell_Shadow_RaiseDead',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 5,
		MONITOR = true,
	}

	aurae.EFFECTS["Perception"] = {
		ICON = 'Spell_Nature_Sleep',
		SCHOOL = aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 20,
		MONITOR = true,
	}
end