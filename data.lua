aurae_DR_CLASS = {
	["Bash"] = 1,
	["Hammer of Justice"] = 1,
	["Cheap Shot"] = 1,
	["Charge Stun"] = 1,
	["Intercept Stun"] = 1,
	["Concussion Blow"] = 1,

	["Fear"] = 2,
	["Howl of Terror"] = 2,
	["Seduction"] = 2,
	["Intimidating Shout"] = 2,
	["Psychic Scream"] = 2,

	["Polymorph"] = 3,
	["Sap"] = 3,
	["Gouge"] = 3,

	["Entangling Roots"] = 4,
	["Frost Nova"] = 4,

	-- ["Freezing Trap"] = 5,
	["Wyvern String"] = 5,

	["Blind"] = 6,

	["Hibernate"] = 7,

	["Mind Control"] = 8,

	["Kidney Shot"] = 9,

	["Death Coil"] = 10,

	["Frost Shock"] = 11,
}

aurae_DELAY = {
	["Fireball"] = true,
	["Frostbolt"] = true,
	["Concussive Shot"] = true,
	["Scorpid Sting"] = true,
	["Viper Sting"] = true,
	["Serpent Sting"] = true,
	["Wyvern Sting"] = true,
}

aurae_RANKS = {
	["Rend"] = {9, 12, 15, 18, 21, 21, 21},
	["Polymorph"] = {20, 30, 40, 50},
	["Fireball"] = {4, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8},
	["Frostbolt"] = {5, 6, 6, 7, 7, 8, 8, 9, 9, 9},
	["Shackle Undead"] = {30, 40, 50},
	["Entangling Roots"] = {12, 15, 18, 21, 24, 27},
	["Bash"] = {2, 3, 4},
	["Hibernate"] = {20, 30, 40},
	["Scare Beast"] = {10, 15, 20},
	["Hammer of Justice"] = {3, 4, 5, 6},
	["Turn Undead"] = {10, 15, 20},
	["Divine Shield"] = {10, 12},
	["Fear"] = {10, 15, 20},
	["Howl of Terror"] = {10, 15},
	["Banish"] = {20, 30},
	["Corruption"] = {12, 15, 18, 18, 18, 18, 18},
	["Sap"] = {25, 35, 45},
	["Kidney Shot"] = {0, 1},
}

aurae_PVP_DURATION = {
	["Sap"] = 15,
	["Polymorph"] = 15,
}

aurae_COMBO = {
	["Rupture"] = 2,
	["Kidney Shot"] = 1,
}

aurae_ACTIONS = {
	["Charge"] = "Charge Stun",
	["Intercept"] = "Intercept Stun",
}

aurae_EFFECTS = {
	["Rupture"] = {
		ICON = 'Ability_Rogue_Rupture',
		DURATION = 6,
	},
		["Garrote"] = {
		ICON = 'Ability_Rogue_Garrote',
		DURATION = 18,
	},
	["Riposte"] = {
		ICON = 'Ability_Warrior_Challange',
		DURATION = 6,
	},
	["Shadow Word: Pain"] = {
		ICON = 'Spell_Shadow_ShadowWordPain',
		DURATION = 18,
	},
	["Devouring Plague"] = {
		ICON = 'Spell_Shadow_BlackPlague',
		DURATION = 24,
	},
	["Vampiric Embrace"] = {
		ICON = 'Spell_Shadow_UnsummonBuilding',
		DURATION = 60,
	},
	["Holy Fire"] = {
		ICON = 'Spell_Holy_SearingLight',
		DURATION = 10,
	},
	["Detect Magic"] = {
		ICON = 'Spell_Holy_Dizzy',
		DURATION = 120,
	},
	["Frostbolt"] = {
		ICON = 'Spell_Frost_FrostBolt02',
		DURATION = 5,
	},
	["Cone of Cold"] = {
		ICON = 'Spell_Frost_Glacier',
		DURATION = 8,
	},
	["Fireball"] = {
		ICON = 'Spell_Fire_FlameBolt',
		DURATION = 4,
	},
	["Pyroblast"] = {
		ICON = 'Spell_Fire_Fireball02',
		DURATION = 12,
	},
	["Flamestrike"] = {
		ICON = 'Spell_Fire_SelfDestruct',
		DURATION = 8,
	},
	["Blast Wave"] = {
		ICON = 'Spell_Holy_Excorcism_02',
		DURATION = 6,
	},
	["Faerie Fire"] = {
		ICON = 'Spell_Nature_FaerieFire',
		DURATION = 40,
	},
	["Faerie Fire (Feral)"] = {
		ICON = 'Spell_Nature_FaerieFire',
		DURATION = 40,
	},
	["Moonfire"] = {
		ICON = 'Spell_Nature_StarFall',
		DURATION = 8,
	},
	["Scorpid Sting"] = {
		ICON = 'Ability_Hunter_CriticalShot',
		DURATION = 20,
	},
	["Serpent Sting"] = {
		ICON = 'Ability_Hunter_Quickshot',
		DURATION = 15,
	},
	["Viper Sting"] = {
		ICON = 'Ability_Hunter_AimedShot',
		DURATION = 8,
	},
	["Concussive Shot"] = {
		ICON = 'Spell_Frost_Stun',
		DURATION = 4,
	},
	["Wing Clip"] = {
		ICON = 'Ability_Rogue_Trip',
		DURATION = 10,
	},
	['Shadowburn'] = {
		ICON = 'Spell_Shadow_ScourgeBuild',
		DURATION = 5,
	},
	["Immolate"] = {
		ICON = 'Spell_Fire_Immolation',
		DURATION = 15,
	},
	["Corruption"] = {
		ICON = 'Spell_Shadow_AbominationExplosion',
		DURATION = 18,
	},
	["Curse of Agony"] = {
		ICON = 'Spell_Shadow_CurseOfSargeras',
		DURATION = 24,
	},
	["Curse of Exhaustion"] = {
		ICON = 'Spell_Shadow_GrimWard',
		DURATION = 12,
	},
	["Curse of the Elements"] = {
		ICON = 'Spell_Shadow_ChillTouch',
		DURATION = 300,
	},
	["Curse of Shadow"] = {
		ICON = 'Spell_Shadow_CurseOfAchimonde',
		DURATION = 300,
	},
	["Curse of Tongues"] = {
		ICON = 'Spell_Shadow_CurseOfTounges',
		DURATION = 30,
	},
	["Curse of Weakness"] = {
		ICON = 'Spell_Shadow_CurseOfMannoroth',
		DURATION = 120,
	},
	["Curse of Recklessness"] = {
		ICON = 'Spell_Shadow_UnholyStrength',
		DURATION = 120,
	},
	["Curse of Doom"] = {
		ICON = 'Spell_Shadow_AuraOfDarkness',
		DURATION = 60,
	},
	["Siphon Life"] = {
		ICON = 'Spell_Shadow_Requiem',
		DURATION = 30,
	},
	["Disarm"] = {
		ICON = 'Ability_Warrior_Disarm',
		DURATION = 10,
	},
	["Mortal Strike"] = {
		ICON = 'Ability_Warrior_SavageBlow',
		DURATION = 10,
	},
	["Rend"] = {
		ICON = 'Ability_Gouge',
		DURATION = 21,
	},
	["Hamstring"] = {
		ICON = 'Ability_ShockWave',
		DURATION = 15,
	},
	["Piercing Howl"] = {
		ICON = 'Spell_Shadow_DeathScream',
		DURATION = 6,
	},
	["Frost Shock"] = {
		ICON = 'Spell_Frost_FrostShock',
		DURATION = 8,
	},
	["Flame Shock"] = {
		ICON = 'Spell_Fire_FlameShock',
		DURATION = 12,
	},
	["Stormstrike"] = {
		ICON = 'Spell_Holy_SealOfMight',
		DURATION = 12,
	},
	["Gouge"] = {
		ICON = 'Ability_Gouge',
		DURATION = 4,
	},
	["Blind"] = {
		ICON = 'Spell_Shadow_MindSteal',
		DURATION = 10,
	},
	["Sap"] = {
		ICON = 'Ability_Sap',
		DURATION = 45,
	},
	["Kidney Shot"] = {
		ICON = 'Ability_Rogue_KidneyShot',
		DURATION = 1,
	},
	["Cheap Shot"] = {
		ICON = 'Ability_CheapShot',
		DURATION = 4,
	},
	["Shackle Undead"] = {
		ICON = 'Spell_Nature_Slow',
		DURATION = 30,
	},
	["Psychic Scream"] = {
		ICON = 'Spell_Shadow_PsychicScream',
		DURATION = 8,
	},
	["Polymorph"] = {
		ICON = 'Spell_Nature_Polymorph', -- Spell_Magic_PolymorphPig, TODO Ability_Hunter_Pet_Turtle
		DURATION = 20,
	},
	["Frost Nova"] = {
		ICON = 'Spell_Frost_FrostNova',
		DURATION = 8,
	},
	["Entangling Roots"] = {
		ICON = 'Spell_Nature_StrangleVines',
		DURATION = 12,
	},
	["Hibernate"] = {
		ICON = 'Spell_Nature_Sleep',
		DURATION = 20,
	},
	["Feral Charge"] = {
		ICON = 'Ability_Hunter_Pet_Bear',
		DURATION = 4,
	},
	["Pounce"] = {
		ICON = 'Ability_Druid_SupriseAttack',
		DURATION = 2,
	},
	["Bash"] = {
		ICON = 'Ability_Druid_Bash',
		DURATION = 2,
	},
	["Scare Beast"] = {
		ICON = 'Ability_Druid_Cower',
		DURATION = 10,
	},
	["Scatter Shot"] = {
		ICON = 'Ability_GolemStormBolt',
		DURATION = 4,
	},
	["Wyvern Sting"] = {
		ICON = 'INV_Spear_02',
		DURATION = 12,
	},
	["Counterattack"] = {
		ICON = 'Ability_Warrior_Challange',
		DURATION = 5,
	},
	["Hammer of Justice"] = {
		ICON = 'Spell_Holy_SealOfMight',
		DURATION = 3,
	},
	["Repentance"] = {
		ICON = 'Spell_Holy_PrayerOfHealing',
		DURATION = 6,
	},
	["Turn Undead"] = {
		ICON = 'Spell_Holy_TurnUndead',
		DURATION = 10,
	},
	["Fear"] = {
		ICON = 'Spell_Shadow_Possession',
		DURATION = 10,
	},
	["Howl of Terror"] = {
		ICON = 'Spell_Shadow_DeathScream',
		DURATION = 10,
	},
	["Death Coil"] = {
		ICON = 'Spell_Shadow_DeathCoil',
		DURATION = 3,
	},
	["Banish"] = {
		ICON = 'Spell_Shadow_Cripple',
		DURATION = 20,
	},
	["Charge Stun"] = {
		ICON = 'Spell_Frost_Stun',
		DURATION = 10,
	},
	["Intercept Stun"] = {
		ICON = 'Ability_Rogue_Sprint',
		DURATION = 3,
	},
	["Hamstring"] = {
		ICON = 'Ability_ShockWave',
		DURATION = 15,
	},
	["Intimidating Shout"] = {
		ICON = 'Ability_GolemThunderClap',
		DURATION = 8,
	},
	["Concussion Blow"] = {
		ICON = 'Ability_ThunderBolt',
		DURATION = 5,
	},
	["War Stomp"] = {
		ICON = 'Ability_WarStomp',
		DURATION = 2,
	},
-- aurae_EFFECTS["Spell Lock"] = {
-- 	ICON = 'Spell_Shadow_MindRot',
-- 	DURATION = 3,
-- }

-- aurae_EFFECTS["Intimidation"] = {
-- 	ICON = 'Ability_Devour',
-- 	DURATION = 3,
-- }

-- aurae_EFFECTS["Seduction"] = {
-- 	ICON = 'Spell_Shadow_MindSteal',
-- 	DURATION = 15,
-- }

-- -- Green Whelp Armour
-- aurae_EFFECTS["Sleep"] = {
-- 	ICON = 'Spell_Holy_MindVision',
-- 	DURATION = 30,
-- }

-- -- Net O Matic
-- aurae_EFFECTS["Net-o-Matic"] = {
-- 	ICON = 'INV_Misc_Net_01',
-- 	DURATION = 10,
-- }

-- -- Rocket Helm
-- aurae_EFFECTS["Reckless Charge"] = {
-- 	ICON = 'INV_Helmet_49',
-- 	DURATION = 30,
-- }
}