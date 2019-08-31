setfenv(1, setmetatable(select(2, ...), {__index=_G}))

-- ITEM_ACTION = {
-- 	["Goblin Rocket Helmet"] = "reckless charge",
-- 	["Horned Viking Helmet"] = "reckless charge",
-- 	["Slumber Sand"] = "sleep(rank 1)",
-- 	["Magic Dust"] = "sleep(rank 2)",
-- 	["Gnomish Net-o-Matic Projector"] = "net-o-matic",
-- 	["Large Rope Net"] = "trap",
-- 	["Really Sticky Glue"] = "trap",
-- }

ACTION = {
	["riposte"] = {effect="Riposte", duration={6}},
	["frostbolt"] = {effect="Frostbolt", duration={5, 6, 6, 7, 7, 8, 8, 9, 9, 9, 9}},
	["cone of cold"] = {effect="Cone of Cold", duration={8}},
	["blast wave"] = {effect="Blast Wave", duration={6}},
	["wing clip"] = {effect="Wing Clip", duration={10}},
	["curse of exhaustion"] = {effect="Curse of Exhaustion", duration={12}},
	["curse of tongues"] = {effect="Curse of Tongues", duration={30}},
	["disarm"] = {effect="Disarm", duration={10}},
	["mortal strike"] = {effect="Mortal Strike", duration={10}},
	["hamstring"] = {effect="Hamstring", duration={15}},
	["piercing howl"] = {effect="Piercing Howl", duration={6}},
	["frost shock"] = {effect="Frost Shock", duration={8}},
	["gouge"] = {effect="Gouge", duration={4}},
	["blind"] = {effect="Blind", duration={10}},
	["sap"] = {effect="Sap", duration={25, 35, 45}},
	["kidney shot"] = {effect="Kidney Shot", duration={0, 1}},
	["cheap shot"] = {effect="Cheap Shot", duration={4}},
	["shackle undead"] = {effect="Shackle Undead", duration={30, 40, 50}},
	["psychic scream"] = {effect="Psychic Scream", duration={8}},
	["polymorph"] = {effect="Polymorph", duration={20, 30, 40, 50}},
	["polymorph: turtle"] = {effect="Polymorph: Turtle", duration={50}},
	["polymorph: pig"] = {effect="Polymorph: Pig", duration={50}},
	["frost nova"] = {effect="Frost Nova", duration={8}},
	["entangling roots"] = {effect="Entangling Roots", duration={12, 15, 18, 21, 24, 27}},
	["hibernate"] = {effect="Hibernate", duration={20, 30, 40}},
	["feral charge"] = {effect="Feral Charge", duration={4}},
	["pounce"] = {effect="Pounce", duration={2}},
	["bash"] = {effect="Bash", duration={2, 3, 4}},
	["scare beast"] = {effect="Scare Beast", duration={10, 15, 20}},
	["scatter shot"] = {effect="Scatter Shot", duration={4}},
	["wyvern sting"] = {effect="Wyvern Sting", duration={12}},
	["concussive shot"] = {effect="Concussive Shot", duration={4}},
	["counterattack"] = {effect="Counterattack", duration={5}},
	["hammer of justice"] = {effect="Hammer of Justice", duration={3, 4, 5, 6}},
	["repentance"] = {effect="Repentance", duration={6}},
	["turn undead"] = {effect="Turn Undead", duration={10, 15, 20}},
	["fear"] = {effect="Fear", duration={10, 15, 20}},
	["howl of terror"] = {effect="Howl of Terror", duration={10, 15}},
	["death coil"] = {effect="Death Coil", duration={3}},
	["banish"] = {effect="Banish", duration={20, 30}},
	["intimidating shout"] = {effect="Intimidating Shout", duration={8}},
	["concussion blow"] = {effect="Concussion Blow", duration={5}},
	["war stomp"] = {effect="War Stomp", duration={2}},
	["intercept"] = {effect="Intercept Stun", duration={3}},
	["reckless charge"] = {effect="Reckless Charge", duration={30}},
	["sleep"] = {effect="Sleep", duration={20, 30}},
	["net-o-matic"] = {effect="Net-o-Matic", duration={10}},
	["large rope net"] = {effect="Trap", duration={10}},
	["tidal charm"] = {effect="Tidal Charm", duration={3}},
	["silence"] = {effect="Silence", duration={5}},
	["counterspell"] = {effect="Counterspell - Silenced", duration={4}},
	["kick"] = {effect="Kick - Silenced", duration={2}},
}

PROJECTILE = {
	["death coil"] = true,
	["frostbolt"] = true,
	["wyvern sting"] = true,
	["concussive shot"] = true,
	["net-o-matic"] = true,
	["trap"] = true,
}

AOE = {
	["cone of cold"] = true,
	["blast wave"] = true,
	["piercing howl"] = true,
	["psychic scream"] = true,
	["frost nova"] = true,
	["howl of terror"] = true,
	["war stomp"] = true,
}

COMBO = {
	["kidney shot"] = 1,
}

local function talentRank(i, j)
	local _, _, _, _, rank = GetTalentInfo(i, j)
	return rank
end

BONUS = {
	["gouge"] = function()
		return talentRank(2, 1) * .5
	end,
	["cone of cold"] = function()
		return min(1, talentRank(3, 2)) * .5 + talentRank(3, 2) * .5
	end,
	["frostbolt"] = function()
		return min(1, talentRank(3, 2)) * .5 + talentRank(3, 2) * .5
	end,
	["pounce"] = function()
		return talentRank(2, 4) * .5
	end,
	["bash"] = function()
		return talentRank(2, 4) * .5
	end,
}

ICON = {
	["Riposte"] = 'Ability_Warrior_Challange',
	["Frostbolt"] = 'Spell_Frost_FrostBolt02',
	["Cone of Cold"] = 'Spell_Frost_Glacier',
	["Blast Wave"] = 'Spell_Holy_Excorcism_02',
	["Wing Clip"] = 'Ability_Rogue_Trip',
	["Curse of Exhaustion"] = 'Spell_Shadow_GrimWard',
	["Curse of Tongues"] = 'Spell_Shadow_CurseOfTounges',
	["Disarm"] = 'Ability_Warrior_Disarm',
	["Mortal Strike"] = 'Ability_Warrior_SavageBlow',
	["Hamstring"] = 'Ability_ShockWave',
	["Piercing Howl"] = 'Spell_Shadow_DeathScream',
	["Frost Shock"] = 'Spell_Frost_FrostShock',
	["Gouge"] = 'Ability_Gouge',
	["Blind"] = 'Spell_Shadow_MindSteal',
	["Sap"] = 'Ability_Sap',
	["Kidney Shot"] = 'Ability_Rogue_KidneyShot',
	["Cheap Shot"] = 'Ability_CheapShot',
	["Shackle Undead"] = 'Spell_Nature_Slow',
	["Psychic Scream"] = 'Spell_Shadow_PsychicScream',
	["Polymorph"] = 'Spell_Nature_Polymorph',
	["Polymorph: Turtle"] = 'Ability_Hunter_Pet_Turtle',
	["Polymorph: Pig"] = 'Spell_Magic_PolymorphPig',
	["Frost Nova"] = 'Spell_Frost_FrostNova',
	["Entangling Roots"] = 'Spell_Nature_StrangleVines',
	["Hibernate"] = 'Spell_Nature_Sleep',
	["Feral Charge"] = 'Ability_Hunter_Pet_Bear',
	["Pounce"] = 'Ability_Druid_SupriseAttack',
	["Bash"] = 'Ability_Druid_Bash',
	["Scare Beast"] = 'Ability_Druid_Cower',
	["Scatter Shot"] = 'Ability_GolemStormBolt',
	["Wyvern Sting"] = 'INV_Spear_02',
	["Concussive Shot"] = 'Spell_Frost_Stun',
	["Counterattack"] = 'Ability_Warrior_Challange',
	["Hammer of Justice"] = 'Spell_Holy_SealOfMight',
	["Repentance"] = 'Spell_Holy_PrayerOfHealing',
	["Turn Undead"] = 'Spell_Holy_TurnUndead',
	["Fear"] = 'Spell_Shadow_Possession',
	["Howl of Terror"] = 'Spell_Shadow_DeathScream',
	["Death Coil"] = 'Spell_Shadow_DeathCoil',
	["Banish"] = 'Spell_Shadow_Cripple',
	["Hamstring"] = 'Ability_ShockWave',
	["Intimidating Shout"] = 'Ability_GolemThunderClap',
	["Concussion Blow"] = 'Ability_ThunderBolt',
	["War Stomp"] = 'Ability_WarStomp',
	["Intercept Stun"] = 'Spell_Frost_Stun',
	["Tidal Charm"] = 'Spell_Frost_SummonWaterElemental',
	["Sleep"] = 'Spell_Holy_MindVision',
	["Net-o-Matic"] = 'INV_Misc_Net_01',
	["Trap"] = 'INV_Misc_Net_01',
	["Reckless Charge"] = 'Spell_Nature_AstralRecal',
	["Seduction"] = 'Spell_Shadow_MindSteal',
	["Freezing Trap Effect"] = 'Spell_Frost_ChainsOfIce',
	["Crippling Poison"] = 'Ability_PoisonSting',
	["Silence"] = 'Spell_Shadow_ImpPhaseShift',
	["Counterspell - Silenced"] = 'Spell_Frost_IceShock',
	["Kick - Silenced"] = 'Ability_Kick',
	["Blackout"] = 'Spell_Shadow_GatherShadows',
	["Impact"] = 'Spell_Fire_MeteorStorm',
	["Aftermath"] = 'Spell_Fire_Fire',
}

DR_CLASS = {
	["Fear"] = 1,
	["Howl of Terror"] = 1,
	["Seduction"] = 1,

	["Polymorph"] = 2,
	["Polymorph: Turtle"] = 2,
	["Polymorph: Pig"] = 2,

	["Freezing Trap Effect"] = 3,
	["Wyvern Sting"] = 3,

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

UNIQUENESS_CLASS = {
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

HEARTBEAT = {
	["Scare Beast"] = true,
	["Freezing Trap"] = true,
	["Entangling Roots"] = true,
	["Hibernate"] = true,
	["Fear"] = true,
	["Sap"] = true,
	["Polymorph"] = true,
	["Polymorph: Turtle"] = true,
	["Polymorph: Pig"] = true,
	["Reckless Charge"] = true,
	["Sleep"] = true,
}