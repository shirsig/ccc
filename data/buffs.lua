local _G = getfenv(0)
function _G.aurae_ConfigBuff()

	-- Rogue

	aurae.EFFECTS["Adrenaline Rush"] = {
		ICON = 'Spell_Shadow_ShadowWordDominate',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Sprint"] = {
		ICON = 'Ability_Rogue_Sprint',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Evasion"] = {
		ICON = 'Spell_Shadow_ShadowWard',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Blade Flurry"] = {
		ICON = 'Ability_GhoulFrenzy',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	-- Priest

	aurae.EFFECTS["Shadow Word: Shield"] = {
		ICON = 'Spell_Holy_PowerWordShield',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 30,
		MONITOR = true,
	}
	aurae.EFFECTS["Renew"] = {
		ICON = 'Spell_Holy_Renew',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS["Power Infusion"] = {
		ICON = 'Spell_Holy_PowerInfusion',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}

	-- Mage

	aurae.EFFECTS["Arcane Power"] = {
		ICON = 'Spell_Nature_Lightning',
		SCHOOL = _G.aurae_SCHOOL.ARCANE,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS["Evocation"] = {
		ICON = 'Spell_Nature_Purge',
		SCHOOL = _G.aurae_SCHOOL.ARCANE,
		ETYPE = ETYPE_BUFF,
		DURATION = 8,
		MONITOR = true,
	}

	aurae.EFFECTS["Ice Block"] = {
		ICON = 'Spell_Frost_Frost',
		SCHOOL = _G.aurae_SCHOOL.FROST,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}

	-- Druid

	aurae.EFFECTS["Nature's Grasp"] = {
		ICON = 'Spell_Nature_NaturesWrath',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_BUFF,
		DURATION = 45,
		MONITOR = true,
	}
	aurae.EFFECTS["Rejuvenation"] = {
		ICON = 'Spell_Nature_Rejuvenation',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_BUFF,
		DURATION = 12,
		MONITOR = true,
	}
	aurae.EFFECTS["Regrowth"] = {
		ICON = 'Spell_Nature_ResistNature',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_BUFF,
		DURATION = 21,
		MONITOR = false,
	}
	aurae.EFFECTS["Dash"] = {
		ICON = 'Ability_Druid_Dash',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Innervate"] = {
		ICON = 'Spell_Nature_Lightning',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_BUFF,
		DURATION = 20,
		MONITOR = true,
	}
	aurae.EFFECTS["Barkskin"] = {
		ICON = 'Spell_Nature_StoneClawTotem',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Frenzied Regeneration"] = {
		ICON = 'Ability_BullRush',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}

	-- Hunter

	aurae.EFFECTS["Deterrence"] = {
		ICON = 'Ability_Whirlwind',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}
	aurae.EFFECTS["Rapid Fire"] = {
		ICON = 'Ability_Hunter_RunningShot',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}

	-- Paladin

	aurae.EFFECTS["Divine Shield"] = {
		ICON = 'Spell_Holy_DivineIntervention',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 12,
		MONITOR = true,
	}
	aurae.EFFECTS["Blessing of Protection"] = {
		ICON = 'Spell_Holy_SealOfProtection',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}
	aurae.EFFECTS["Blessing of Freedom"] = {
		ICON = 'Spell_Holy_SealOfValor',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}

	-- Warlock

	aurae.EFFECTS["Sacrifice"] = {
		ICON = 'Spell_Shadow_SacrificialShield',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_BUFF,
		DURATION = 30,
		MONITOR = true,
	}
	aurae.EFFECTS["Spellstone"] = {
		ICON = 'INV_Misc_Gem_Sapphire_01',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_BUFF,
		DURATION = 45,
		MONITOR = true,
	}

	-- Warrior

	aurae.EFFECTS["Berserker Rage"] = {
		ICON = 'Spell_Nature_AncestralGuardian',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}
	aurae.EFFECTS["Bloodrage"] = {
		ICON = 'Ability_Racial_BloodRage',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = false,
	}
	aurae.EFFECTS["Last Stand"] = {
		ICON = 'Spell_Holy_AshesToAshes',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 20,
		MONITOR = true,
	}
	aurae.EFFECTS["Retaliation"] = {
		ICON = 'Ability_Warrior_Challange',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Shield Wall"] = {
		ICON = 'Ability_Warrior_ShieldWall',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 10,
		MONITOR = true,
	}
	aurae.EFFECTS["Recklessness"] = {
		ICON = 'Ability_CriticalStrike',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 15,
		MONITOR = true,
	}
	aurae.EFFECTS["Death Wish"] = {
		ICON = 'Spell_Shadow_DeathPact',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 30,
		MONITOR = true,
	}

	-- Misc

	aurae.EFFECTS["Will of the Forsaken"] = {
		ICON = 'Spell_Shadow_RaiseDead',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 5,
		MONITOR = true,
	}

	aurae.EFFECTS["Perception"] = {
		ICON = 'Spell_Nature_Sleep',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_BUFF,
		DURATION = 20,
		MONITOR = true,
	}
end