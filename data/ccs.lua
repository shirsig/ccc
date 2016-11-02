-- Rogue

aurae.EFFECTS["Gouge"] = {
	ICON = 'Ability_Gouge',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 4,
}

aurae.EFFECTS["Blind"] = {
	ICON = 'Spell_Shadow_MindSteal',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 10,
}

aurae.EFFECTS["Sap"] = {
	ICON = 'Ability_Sap',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 45,
	PVP_DURATION = 15,
}

aurae.EFFECTS["Kidney Shot"] = {
	ICON = 'Ability_Rogue_KidneyShot',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 1,
	COMBO = true,
	A = 1, -- f(x) = A * x + DURATION => 1 point = 2 sec, 5 point = 6 sec
}

aurae.EFFECTS["Cheap Shot"] = {
	ICON = 'Ability_CheapShot',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 4,
}

-- Priest

aurae.EFFECTS["Shackle Undead"] = {
	ICON = 'Spell_Nature_Slow',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	DURATION = 30, -- 40 50
	DIMINISH = 0
}

aurae.EFFECTS["Psychic Scream"] = {
	ICON = 'Spell_Shadow_PsychicScream',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 8,
	DIMINISH = 0
}

aurae.EFFECTS["Blackout"] = {
	ICON = 'Spell_Shadow_GatherShadows',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 2,
	DIMINISH = 0
}

-- Mage

aurae.EFFECTS["Polymorph"] = {
	ICON = 'Spell_Nature_Polymorph', -- Spell_Magic_PolymorphPig, TODO Ability_Hunter_Pet_Turtle
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_CC,
	DURATION = 20,
	PVP_DURATION = 15,
}

aurae.EFFECTS["Frost Nova"] = {
	ICON = 'Spell_Frost_FreezingBreath',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_CC,
	DURATION = 8,
}

aurae.EFFECTS["Frostbite"] = {
	ICON = 'Spell_Frost_FrostArmor',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_CC,
	DURATION = 5,
}

-- Druid

aurae.EFFECTS["Entangling Roots"] = {
	ICON = 'Spell_Nature_StrangleVines',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	DURATION = 12, -- 15 18 21 24 27
}

aurae.EFFECTS["Hibernate"] = {
	ICON = 'Spell_Nature_Sleep',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	DURATION = 20, -- 30 40
}

aurae.EFFECTS["Feral Charge"] = {
	ICON = 'Ability_Hunter_Pet_Bear',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 4,
}

aurae.EFFECTS["Improved Starfire"] = {
	ICON = 'Spell_Arcane_StarFire',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_CC,
	DURATION = 3,
}

aurae.EFFECTS["Pounce"] = {
	ICON = 'Ability_Druid_SupriseAttack',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 2,
}

aurae.EFFECTS["Bash"] = {
	ICON = 'Ability_Druid_Bash',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 2, -- 2, 3, 4
}

-- Hunter

aurae.EFFECTS["Freezing Trap Effect"] = {
	ICON = 'Spell_Frost_ChainsOfIce',
	SCHOOL = aurae_SCHOOL.FROST,
	ETYPE = ETYPE_CC,
	DURATION = 10, -- 15 20
}

aurae.EFFECTS["Improved Concussive Shot"] = {
	ICON = 'Spell_Frost_IceShock',
	SCHOOL = aurae_SCHOOL.ARCANE,
	ETYPE = ETYPE_CC,
	DURATION = 4,
}

aurae.EFFECTS["Scare Beast"] = {
	ICON = 'Ability_Druid_Cower',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	DURATION = 10, -- 15 20
}

aurae.EFFECTS["Scatter Shot"] = {
	ICON = 'Ability_GolemStormBolt',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 4, -- 15 20
}

aurae.EFFECTS["Intimidation"] = {
	ICON = 'Ability_Devour',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 3, -- 15 20
}

aurae.EFFECTS["Counterattack"] = {
	ICON = 'Ability_Warrior_Challange',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 5,
}

aurae.EFFECTS["Improved Wingclip"] = {
	ICON = 'Ability_Rogue_Trip',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 5,
}

aurae.EFFECTS["Wyvernsting"] = {
	ICON = 'INV_Spear_02',
	SCHOOL = aurae_SCHOOL.NATURE,
	ETYPE = ETYPE_CC,
	DURATION = 12,
}

aurae.EFFECTS["Entrapment"] = {
	ICON = 'Spell_Nature_StrangleVines',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 5,
}

-- Paladin

aurae.EFFECTS["Hammer of Justice"] = {
	ICON = 'Spell_Holy_SealOfMight',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	DURATION = 3, -- 4 5 6
}

aurae.EFFECTS["Repentance"] = {
	ICON = 'Spell_Holy_PrayerOfHealing',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	DURATION = 6,
}

aurae.EFFECTS["Turn Undead"] = {
	ICON = 'Spell_Holy_TurnUndead',
	SCHOOL = aurae_SCHOOL.HOLY,
	ETYPE = ETYPE_CC,
	DURATION = 10, -- 15 20
}

-- Warlock

aurae.EFFECTS["Seduction"] = {
	ICON = 'Spell_Shadow_MindSteal',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 15,
}

aurae.EFFECTS["Fear"] = {
	ICON = 'Spell_Shadow_Possession',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 10, -- 15 20
}

aurae.EFFECTS["Howl of Terror"] = {
	ICON = 'Spell_Shadow_DeathScream',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 10, -- 15
}

aurae.EFFECTS["Death Coil"] = {
	ICON = 'Spell_Shadow_DeathCoil',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 3,
}

aurae.EFFECTS["Banish"] = {
	ICON = 'Spell_Shadow_Cripple',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 20, -- 30
}

-- Warrior

aurae.EFFECTS["Intercept Stun"] = {
	ICON = 'Ability_Rogue_Sprint',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 3,
}

aurae.EFFECTS["Mace Specialization"] = {
	ICON = 'INV_Mace_01',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 3,
}

aurae.EFFECTS["Hamstring"] = {
	ICON = 'Ability_ShockWave',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 15,
}

aurae.EFFECTS["Improved Hamstring"] = {
	ICON = 'Ability_ShockWave',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 3,
}

aurae.EFFECTS["Intimidating Shout"] = {
	ICON = 'Ability_GolemThunderClap',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 8,
}

aurae.EFFECTS["Revenge Stun"] = {
	ICON = 'Ability_Warrior_Revenge',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 3,
}

aurae.EFFECTS["Concussion Blow"] = {
	ICON = 'Ability_ThunderBolt',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 5,
}

-- Misc

aurae.EFFECTS["War Stomp"] = {
	ICON = 'Ability_WarStomp',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 2,
}

-- Green Whelp Armour
aurae.EFFECTS["Sleep"] = {
	ICON = 'Spell_Holy_MindVision',
	SCHOOL = aurae_SCHOOL.SHADOW,
	ETYPE = ETYPE_CC,
	DURATION = 30,
}

-- Net O Matic
aurae.EFFECTS["Net-o-Matic"] = {
	ICON = 'INV_Misc_Net_01',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 10,
}

-- Rocket Helm
aurae.EFFECTS["Reckless Charge"] = {
	ICON = 'INV_Helmet_49',
	SCHOOL = aurae_SCHOOL.PHYSICAL,
	ETYPE = ETYPE_CC,
	DURATION = 30,
}