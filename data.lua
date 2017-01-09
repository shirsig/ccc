ccwatch_DR_CLASS = {
	["Fear"] = 1,
	["Howl of Terror"] = 1,
	["Seduction"] = 1,

	["Polymorph"] = 2,
	["Polymorph: Turtle"] = 2,
	["Polymorph: Pig"] = 2,

	["Freezing Trap Effect"] = 3,
	["Wyvern String"] = 3,

	["Sap"] = 4,
	["Gouge"] = 4,

	["Scare Beast"] = 5,

	["Entangling Roots"] = 6,

	["Frost Nova"] = 7,

	["Cheap Shot"] = 8,

	["Kidney Shot"] = 9,

	["Blind"] = 10,

	["Hibernate"] = 11,

	["Frost Shock"] = 12,
}

ccwatch_UNIQUENESS_CLASS = {
	["Polymorph"] = 1,
	["Polymorph: Turtle"] = 1,
	["Polymorph: Pig"] = 1,
	["Fear"] = 2,
	["Sap"] = 3,
	["Entangling Roots"] = 4,
	["Hibernate"] = 5,
	["Turn Undead"] = 6,
	["Shackle Undead"] = 7,
	["Banish"] = 8,
	["Scare Beast"] = 9,
}

ccwatch_PROJECTILE = {
	["Death Coil"] = true,
	["Frostbolt"] = true,
	["Wyvern Sting"] = true,
	["Concussive Shot"] = true,
}

local function talentRank(i, j)
	local _, _, _, _, rank = GetTalentInfo(i, j)
	return rank
end

ccwatch_BONUS = {
	["Freezing Trap"] = function()
		return 20 * talentRank(3, 7) * .15
	end,
	["Seduction"] = function()
		return talentRank(2, 7) * 1.5
	end,
	["Gouge"] = function()
		return talentRank(2, 1) * .5
	end,
	["Cone of Cold"] = function()
		return min(1, talentRank(3, 2)) * .5 + talentRank(3, 2) * .5
	end,
	["Frostbolt"] = function()
		return min(1, talentRank(3, 2)) * .5 + talentRank(3, 2) * .5
	end,
	["Pounce"] = function()
		return talentRank(2, 4) * .5
	end,
	["Bash"] = function()
		return talentRank(2, 4) * .5
	end,
}

ccwatch_HEARTBEAT = {
	["Scare Beast"] = true,
	["Freezing Trap"] = true,
	["Entangling Roots"] = true,
	["Hibernate"] = true,
	["Fear"] = true,
	["Sap"] = true,
	["Polymorph"] = true,
	["Polymorph: Turtle"] = true,
	["Polymorph: Pig"] = true,
}

ccwatch_COMBO = {
	["Kidney Shot"] = 1,
}

ccwatch_ACTION = {
	["Riposte"] = true,
	["Frostbolt"] = true,
	["Cone of Cold"] = true,
	["Blast Wave"] = true,
	["Wing Clip"] = true,
	["Curse of Exhaustion"] = true,
	["Curse of Tongues"] = true,
	["Disarm"] = true,
	["Mortal Strike"] = true,
	["Hamstring"] = true,
	["Piercing Howl"] = true,
	["Frost Shock"] = true,
	["Gouge"] = true,
	["Blind"] = true,
	["Sap"] = true,
	["Kidney Shot"] = true,
	["Cheap Shot"] = true,
	["Shackle Undead"] = true,
	["Psychic Scream"] = true,
	["Polymorph"] = true,
	["Polymorph: Turtle"] = true,
	["Polymorph: Pig"] = true,
	["Frost Nova"] = true,
	["Entangling Roots"] = true,
	["Hibernate"] = true,
	["Feral Charge"] = true,
	["Pounce"] = true,
	["Bash"] = true,
	["Scare Beast"] = true,
	["Scatter Shot"] = true,
	["Wyvern Sting"] = true,
	["Concussive Shot"] = true,
	["Counterattack"] = true,
	["Hammer of Justice"] = true,
	["Repentance"] = true,
	["Turn Undead"] = true,
	["Fear"] = true,
	["Howl of Terror"] = true,
	["Death Coil"] = true,
	["Banish"] = true,
	["Hamstring"] = true,
	["Intimidating Shout"] = true,
	["Concussion Blow"] = true,
	["War Stomp"] = true,	
}

ccwatch_EFFECTS = {
	["Riposte"] = {
		ICON = 'Ability_Warrior_Challange',
		DURATION = {6},
	},
	["Frostbolt"] = {
		ICON = 'Spell_Frost_FrostBolt02',
		DURATION = {5, 6, 6, 7, 7, 8, 8, 9, 9, 9, 9},
	},
	["Cone of Cold"] = {
		ICON = 'Spell_Frost_Glacier',
		DURATION = {8},
	},
	["Blast Wave"] = {
		ICON = 'Spell_Holy_Excorcism_02',
		DURATION = {6},
	},
	["Wing Clip"] = {
		ICON = 'Ability_Rogue_Trip',
		DURATION = {10},
	},
	["Curse of Exhaustion"] = {
		ICON = 'Spell_Shadow_GrimWard',
		DURATION = {12},
	},
	["Curse of Tongues"] = {
		ICON = 'Spell_Shadow_CurseOfTounges',
		DURATION = {30},
	},
	["Disarm"] = {
		ICON = 'Ability_Warrior_Disarm',
		DURATION = {10},
	},
	["Mortal Strike"] = {
		ICON = 'Ability_Warrior_SavageBlow',
		DURATION = {10},
	},
	["Hamstring"] = {
		ICON = 'Ability_ShockWave',
		DURATION = {15},
	},
	["Piercing Howl"] = {
		ICON = 'Spell_Shadow_DeathScream',
		DURATION = {6},
	},
	["Frost Shock"] = {
		ICON = 'Spell_Frost_FrostShock',
		DURATION = {8},
	},
	["Gouge"] = {
		ICON = 'Ability_Gouge',
		DURATION = {4},
	},
	["Blind"] = {
		ICON = 'Spell_Shadow_MindSteal',
		DURATION = {10},
	},
	["Sap"] = {
		ICON = 'Ability_Sap',
		DURATION = {25, 35, 45},
	},
	["Kidney Shot"] = {
		ICON = 'Ability_Rogue_KidneyShot',
		DURATION = {0, 1},
	},
	["Cheap Shot"] = {
		ICON = 'Ability_CheapShot',
		DURATION = {4},
	},
	["Shackle Undead"] = {
		ICON = 'Spell_Nature_Slow',
		DURATION = {30, 40, 50},
	},
	["Psychic Scream"] = {
		ICON = 'Spell_Shadow_PsychicScream',
		DURATION = {8},
	},
	["Polymorph"] = {
		ICON = 'Spell_Nature_Polymorph',
		DURATION = {20, 30, 40, 50},
	},
	["Polymorph: Turtle"] = {
		ICON = "Ability_Hunter_Pet_Turtle",
		DURATION = {50},
	},
	["Polymorph: Pig"] = {
		ICON = "Spell_Magic_PolymorphPig",
		DURATION = {50},
	},
	["Frost Nova"] = {
		ICON = 'Spell_Frost_FrostNova',
		DURATION = {8},
	},
	["Entangling Roots"] = {
		ICON = 'Spell_Nature_StrangleVines',
		DURATION = {12, 15, 18, 21, 24, 27},
	},
	["Hibernate"] = {
		ICON = 'Spell_Nature_Sleep',
		DURATION = {20, 30, 40},
	},
	["Feral Charge"] = {
		ICON = 'Ability_Hunter_Pet_Bear',
		DURATION = {4},
	},
	["Pounce"] = {
		ICON = 'Ability_Druid_SupriseAttack',
		DURATION = {2},
	},
	["Bash"] = {
		ICON = 'Ability_Druid_Bash',
		DURATION = {2, 3, 4},
	},
	["Scare Beast"] = {
		ICON = 'Ability_Druid_Cower',
		DURATION = {10, 15, 20},
	},
	["Scatter Shot"] = {
		ICON = 'Ability_GolemStormBolt',
		DURATION = {4},
	},
	["Wyvern Sting"] = {
		ICON = 'INV_Spear_02',
		DURATION = {12},
	},
	["Concussive Shot"] = {
		ICON = 'Spell_Frost_Stun',
		DURATION = {4},
	},
	["Counterattack"] = {
		ICON = 'Ability_Warrior_Challange',
		DURATION = {5},
	},
	["Hammer of Justice"] = {
		ICON = 'Spell_Holy_SealOfMight',
		DURATION = {3, 4, 5, 6},
	},
	["Repentance"] = {
		ICON = 'Spell_Holy_PrayerOfHealing',
		DURATION = {6},
	},
	["Turn Undead"] = {
		ICON = 'Spell_Holy_TurnUndead',
		DURATION = {10, 15, 20},
	},
	["Fear"] = {
		ICON = 'Spell_Shadow_Possession',
		DURATION = {10, 15, 20},
	},
	["Howl of Terror"] = {
		ICON = 'Spell_Shadow_DeathScream',
		DURATION = {10, 15},
	},
	["Death Coil"] = {
		ICON = 'Spell_Shadow_DeathCoil',
		DURATION = {3},
	},
	["Banish"] = {
		ICON = 'Spell_Shadow_Cripple',
		DURATION = {20, 30},
	},
	["Hamstring"] = {
		ICON = 'Ability_ShockWave',
		DURATION = {15},
	},
	["Intimidating Shout"] = {
		ICON = 'Ability_GolemThunderClap',
		DURATION = {8},
	},
	["Concussion Blow"] = {
		ICON = 'Ability_ThunderBolt',
		DURATION = {5},
	},
	["War Stomp"] = {
		ICON = 'Ability_WarStomp',
		DURATION = {2},
	},
	["Seduction"] = {
		ICON = 'Spell_Shadow_MindSteal',
		DURATION = {15},
	},
	["Freezing Trap Effect"] = {
		ICON = 'Spell_Frost_ChainsOfIce',
		DURATION = {20},
	},

-- ["Intercept Stun"] = {
-- 	ICON = 'Spell_Frost_Stun',
-- 	DURATION = {3},
-- },

-- -- Tidal Charm
-- ["Tidal Charm"] = {
-- 	ICON = 'Spell_Frost_SummonWaterElemental',
-- 	DURATION = {3},
-- },

-- -- Magic Dust
-- ["Sleep"] = {
-- 	ICON = 'Spell_Holy_MindVision',
-- 	DURATION = {30},
-- },

-- -- Net O Matic
-- ["Net-o-Matic"] = {
-- 	ICON = 'INV_Misc_Net_01',
-- 	DURATION = {10},
-- },

-- -- Rocket Helm
-- ["Reckless Charge"] = {
-- 	ICON = 'INV_Helmet_49',
-- 	DURATION = {30},
-- },
}