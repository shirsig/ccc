local _G = getfenv(0)
function _G.aurae_ConfigCC()

	-- Rogue - Stun/Root CCs
	aurae.EFFECTS[_G.aurae_GOUGE] = {
		ICON = 'Ability_Gouge',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 4,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_BLIND] = {
		ICON = 'Spell_Shadow_MindSteal',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 10,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_SAP] = {
		ICON = 'Ability_Sap',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 45,
		PVP_DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_KS] = {
		ICON = 'Ability_Rogue_KidneyShot',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 1,
		COMBO = true,
		A = 1, -- f(x) = A * x + DURATION => 1 point = 2 sec, 5 point = 6 sec
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_CS] = {
		ICON = 'Ability_CheapShot',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 4,
		MONITOR = true,
	}

	-- Priest - Stun/Root CCs
	aurae.EFFECTS["Shackle Undead"] = {
		ICON = 'Spell_Nature_Slow',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_CC,
		DURATION = 30, -- 40 50
		MONITOR = true,
		DIMINISH = 0
	}

	aurae.EFFECTS["Psychic Scream"] = {
		ICON = 'Spell_Shadow_PsychicScream',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_CC,
		DURATION = 8,
		MONITOR = true,
		DIMINISH = 0
	}

	aurae.EFFECTS["Blackout"] = {
		ICON = 'Spell_Shadow_GatherShadows',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_CC,
		DURATION = 2,
		MONITOR = true,
		DIMINISH = 0
	}

	-- Mage - Stun/Root CCs
	aurae.EFFECTS["Polymorph"] = {
		ICON = 'Spell_Nature_Polymorph', -- Spell_Magic_PolymorphPig, TODO Ability_Hunter_Pet_Turtle
		SCHOOL = _G.aurae_SCHOOL.ARCANE,
		ETYPE = ETYPE_CC,
		DURATION = 20,
		PVP_DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS["Frost Nova"] = {
		ICON = 'Spell_Frost_FreezingBreath',
		SCHOOL = _G.aurae_SCHOOL.FROST,
		ETYPE = ETYPE_CC,
		DURATION = 8,
		MONITOR = true,
	}

	aurae.EFFECTS["Frostbite"] = {
		ICON = 'Spell_Frost_FrostArmor',
		SCHOOL = _G.aurae_SCHOOL.FROST,
		ETYPE = ETYPE_CC,
		DURATION = 5,
		MONITOR = true,
	}

	-- Druid - Stun/Root CCs
	aurae.EFFECTS[_G.aurae_ROOTS] = {
		ICON = 'Spell_Nature_StrangleVines',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_CC,
		DURATION = 12, -- 15 18 21 24 27
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_HIBERNATE] = {
		ICON = 'Spell_Nature_Sleep',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_CC,
		DURATION = 20, -- 30 40
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_FERALCHARGE] = {
		ICON = 'Ability_Hunter_Pet_Bear',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 4,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_IMPSTARFIRE] = {
		ICON = 'Spell_Arcane_StarFire',
		SCHOOL = _G.aurae_SCHOOL.ARCANE,
		ETYPE = ETYPE_CC,
		DURATION = 3,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_POUNCE] = {
		ICON = 'Ability_Druid_SupriseAttack',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 2,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_BASH] = {
		ICON = 'Ability_Druid_Bash',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 2, -- 2, 3, 4
		MONITOR = true,
	}

	-- Hunter - Stun/Root CCs
	aurae.EFFECTS[_G.aurae_FREEZINGTRAP] = {
		ICON = 'Spell_Frost_ChainsOfIce',
		SCHOOL = _G.aurae_SCHOOL.FROST,
		ETYPE = ETYPE_CC,
		DURATION = 10, -- 15 20
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_IMPCS] = {
		ICON = 'Spell_Frost_IceShock',
		SCHOOL = _G.aurae_SCHOOL.ARCANE,
		ETYPE = ETYPE_CC,
		DURATION = 4,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_SCAREBEAST] = {
		ICON = 'Ability_Druid_Cower',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_CC,
		DURATION = 10, -- 15 20
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_SCATTERSHOT] = {
		ICON = 'Ability_GolemStormBolt',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 4, -- 15 20
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_INTIMIDATION] = {
		ICON = 'Ability_Devour',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 3, -- 15 20
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_COUNTERATTACK] = {
		ICON = 'Ability_Warrior_Challange',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 5,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_IMPROVEDWINGCLIP] = {
		ICON = 'Ability_Rogue_Trip',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 5,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_WYVERNSTING] = {
		ICON = 'INV_Spear_02',
		SCHOOL = _G.aurae_SCHOOL.NATURE,
		ETYPE = ETYPE_CC,
		DURATION = 12,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_ENTRAPMENT] = {
		ICON = 'Spell_Nature_StrangleVines',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 5,
		MONITOR = true,
	}

	-- Paladin - Stun/Root CCs
	aurae.EFFECTS["Hammer of Justice"] = {
		ICON = 'Spell_Holy_SealOfMight',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_CC,
		DURATION = 3, -- 4 5 6
		MONITOR = true,
	}

	aurae.EFFECTS["Repentance"] = {
		ICON = 'Spell_Holy_PrayerOfHealing',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_CC,
		DURATION = 6,
		MONITOR = true,
	}

	aurae.EFFECTS["Turn Undead"] = {
		ICON = 'Spell_Holy_TurnUndead',
		SCHOOL = _G.aurae_SCHOOL.HOLY,
		ETYPE = ETYPE_CC,
		DURATION = 10, -- 15 20
		MONITOR = true,
	}

	-- Warlock - Stun/Root CCs
	aurae.EFFECTS["Seduction"] = {
		ICON = 'Spell_Shadow_MindSteal',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_CC,
		DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS["Fear"] = {
		ICON = 'Spell_Shadow_Possession',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_CC,
		DURATION = 10, -- 15 20
		MONITOR = true,
	}

	aurae.EFFECTS["Howl of Terror"] = {
		ICON = 'Spell_Shadow_DeathScream',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_CC,
		DURATION = 10, -- 15
		MONITOR = true,
	}

	aurae.EFFECTS["Death Coil"] = {
		ICON = 'Spell_Shadow_DeathCoil',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_CC,
		DURATION = 3,
		MONITOR = true,
	}

	aurae.EFFECTS["Banish"] = {
		ICON = 'Spell_Shadow_Cripple',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_CC,
		DURATION = 20, -- 30
		MONITOR = true,
	}

	-- Warrior - Stun/Root CCs
	aurae.EFFECTS[_G.aurae_INTERCEPT] = {
		ICON = 'Ability_Rogue_Sprint',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 3,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_MACESPE] = {
		ICON = 'INV_Mace_01',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 3,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_HAMSTRING] = {
		ICON = 'Ability_ShockWave',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 15,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_IMPHAMSTRING] = {
		ICON = 'Ability_ShockWave',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 3,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_INTIMIDATINGSHOUT] = {
		ICON = 'Ability_GolemThunderClap',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 8,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_IMPREVENGE] = {
		ICON = 'Ability_Warrior_Revenge',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 3,
		MONITOR = true,
	}

	aurae.EFFECTS[_G.aurae_CONCUSSIONBLOW] = {
		ICON = 'Ability_ThunderBolt',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 5,
		MONITOR = true,
	}

	-- Specific - Stun/Root CCs

	-- Tauren
	aurae.EFFECTS[_G.aurae_WARSTOMP] = {
		ICON = 'Ability_WarStomp',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 2,
		MONITOR = true,
	}

	-- Green Whelp Armour
	aurae.EFFECTS[_G.aurae_SLEEP] = {
		ICON = 'Spell_Holy_MindVision',
		SCHOOL = _G.aurae_SCHOOL.SHADOW,
		ETYPE = ETYPE_CC,
		DURATION = 30,
		MONITOR = true,
	}

	-- Net O Matic
	aurae.EFFECTS[_G.aurae_NETOMATIC] = {
		ICON = 'INV_Misc_Net_01',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 10,
		MONITOR = true,
	}

	-- Reckless Helmet
	aurae.EFFECTS[_G.aurae_ROCKETHELM] = {
		ICON = 'INV_Helmet_49',
		SCHOOL = _G.aurae_SCHOOL.PHYSICAL,
		ETYPE = ETYPE_CC,
		DURATION = 30,
		MONITOR = true,
	}
end