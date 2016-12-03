-- Rogue

aurae.EFFECTS["Gouge"] = {
	ICON = 'Ability_Gouge',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 4,
}

aurae.EFFECTS["Blind"] = {
	ICON = 'Spell_Shadow_MindSteal',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 10,
}

aurae.EFFECTS["Sap"] = {
	ICON = 'Ability_Sap',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 45,
	PVP_DURATION = 15,
}

aurae.EFFECTS["Kidney Shot"] = {
	ICON = 'Ability_Rogue_KidneyShot',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 1,
	COMBO = true,
	A = 1, -- f(x) = A * x + DURATION => 1 point = 2 sec, 5 point = 6 sec
}

aurae.EFFECTS["Cheap Shot"] = {
	ICON = 'Ability_CheapShot',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 4,
}

-- Priest

aurae.EFFECTS["Shackle Undead"] = {
	ICON = 'Spell_Nature_Slow',
	SCHOOL = 'HOLY',
	ETYPE = 'CC',
	DURATION = 30, -- 40 50
	DIMINISH = 0
}

aurae.EFFECTS["Psychic Scream"] = {
	ICON = 'Spell_Shadow_PsychicScream',
	SCHOOL = 'SHADOW',
	ETYPE = 'CC',
	DURATION = 8,
	DIMINISH = 0
}

aurae.EFFECTS["Blackout"] = {
	ICON = 'Spell_Shadow_GatherShadows',
	SCHOOL = 'SHADOW',
	ETYPE = 'CC',
	DURATION = 2,
	DIMINISH = 0
}

-- Mage

aurae.EFFECTS["Polymorph"] = {
	ICON = 'Spell_Nature_Polymorph', -- Spell_Magic_PolymorphPig, TODO Ability_Hunter_Pet_Turtle
	SCHOOL = 'ARCANE',
	ETYPE = 'CC',
	DURATION = 20,
	PVP_DURATION = 15,
}

aurae.EFFECTS["Frost Nova"] = {
	ICON = 'Spell_Frost_FreezingBreath',
	SCHOOL = 'FROST',
	ETYPE = 'CC',
	DURATION = 8,
}

aurae.EFFECTS["Frostbite"] = {
	ICON = 'Spell_Frost_FrostArmor',
	SCHOOL = 'FROST',
	ETYPE = 'CC',
	DURATION = 5,
}

-- Druid

aurae.EFFECTS["Entangling Roots"] = {
	ICON = 'Spell_Nature_StrangleVines',
	SCHOOL = 'NATURE',
	ETYPE = 'CC',
	DURATION = 12, -- 15 18 21 24 27
}

aurae.EFFECTS["Hibernate"] = {
	ICON = 'Spell_Nature_Sleep',
	SCHOOL = 'NATURE',
	ETYPE = 'CC',
	DURATION = 20, -- 30 40
}

aurae.EFFECTS["Feral Charge"] = {
	ICON = 'Ability_Hunter_Pet_Bear',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 4,
}

aurae.EFFECTS["Improved Starfire"] = {
	ICON = 'Spell_Arcane_StarFire',
	SCHOOL = 'ARCANE',
	ETYPE = 'CC',
	DURATION = 3,
}

aurae.EFFECTS["Pounce"] = {
	ICON = 'Ability_Druid_SupriseAttack',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 2,
}

aurae.EFFECTS["Bash"] = {
	ICON = 'Ability_Druid_Bash',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 2, -- 2, 3, 4
}

-- Hunter

aurae.EFFECTS["Freezing Trap Effect"] = {
	ICON = 'Spell_Frost_ChainsOfIce',
	SCHOOL = 'FROST',
	ETYPE = 'CC',
	DURATION = 10, -- 15 20
}

aurae.EFFECTS["Improved Concussive Shot"] = {
	ICON = 'Spell_Frost_IceShock',
	SCHOOL = 'ARCANE',
	ETYPE = 'CC',
	DURATION = 4,
}

aurae.EFFECTS["Scare Beast"] = {
	ICON = 'Ability_Druid_Cower',
	SCHOOL = 'NATURE',
	ETYPE = 'CC',
	DURATION = 10, -- 15 20
}

aurae.EFFECTS["Scatter Shot"] = {
	ICON = 'Ability_GolemStormBolt',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 4, -- 15 20
}

aurae.EFFECTS["Intimidation"] = {
	ICON = 'Ability_Devour',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 3, -- 15 20
}

aurae.EFFECTS["Counterattack"] = {
	ICON = 'Ability_Warrior_Challange',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 5,
}

aurae.EFFECTS["Improved Wingclip"] = {
	ICON = 'Ability_Rogue_Trip',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 5,
}

aurae.EFFECTS["Wyvernsting"] = {
	ICON = 'INV_Spear_02',
	SCHOOL = 'NATURE',
	ETYPE = 'CC',
	DURATION = 12,
}

aurae.EFFECTS["Entrapment"] = {
	ICON = 'Spell_Nature_StrangleVines',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 5,
}

-- Paladin

aurae.EFFECTS["Hammer of Justice"] = {
	ICON = 'Spell_Holy_SealOfMight',
	SCHOOL = 'HOLY',
	ETYPE = 'CC',
	DURATION = 3, -- 4 5 6
}

aurae.EFFECTS["Repentance"] = {
	ICON = 'Spell_Holy_PrayerOfHealing',
	SCHOOL = 'HOLY',
	ETYPE = 'CC',
	DURATION = 6,
}

aurae.EFFECTS["Turn Undead"] = {
	ICON = 'Spell_Holy_TurnUndead',
	SCHOOL = 'HOLY',
	ETYPE = 'CC',
	DURATION = 10, -- 15 20
}

-- Warlock

aurae.EFFECTS["Seduction"] = {
	ICON = 'Spell_Shadow_MindSteal',
	SCHOOL = 'SHADOW',
	ETYPE = 'CC',
	DURATION = 15,
}

aurae.EFFECTS["Fear"] = {
	ICON = 'Spell_Shadow_Possession',
	SCHOOL = 'SHADOW',
	ETYPE = 'CC',
	DURATION = 10, -- 15 20
}

aurae.EFFECTS["Howl of Terror"] = {
	ICON = 'Spell_Shadow_DeathScream',
	SCHOOL = 'SHADOW',
	ETYPE = 'CC',
	DURATION = 10, -- 15
}

aurae.EFFECTS["Death Coil"] = {
	ICON = 'Spell_Shadow_DeathCoil',
	SCHOOL = 'SHADOW',
	ETYPE = 'CC',
	DURATION = 3,
}

aurae.EFFECTS["Banish"] = {
	ICON = 'Spell_Shadow_Cripple',
	SCHOOL = 'SHADOW',
	ETYPE = 'CC',
	DURATION = 20, -- 30
}

-- Warrior

aurae.EFFECTS["Intercept Stun"] = {
	ICON = 'Ability_Rogue_Sprint',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 3,
}

aurae.EFFECTS["Mace Specialization"] = {
	ICON = 'INV_Mace_01',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 3,
}

aurae.EFFECTS["Hamstring"] = {
	ICON = 'Ability_ShockWave',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 15,
}

aurae.EFFECTS["Improved Hamstring"] = {
	ICON = 'Ability_ShockWave',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 3,
}

aurae.EFFECTS["Intimidating Shout"] = {
	ICON = 'Ability_GolemThunderClap',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 8,
}

aurae.EFFECTS["Revenge Stun"] = {
	ICON = 'Ability_Warrior_Revenge',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 3,
}

aurae.EFFECTS["Concussion Blow"] = {
	ICON = 'Ability_ThunderBolt',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 5,
}

-- Misc

aurae.EFFECTS["War Stomp"] = {
	ICON = 'Ability_WarStomp',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 2,
}

-- Green Whelp Armour
aurae.EFFECTS["Sleep"] = {
	ICON = 'Spell_Holy_MindVision',
	SCHOOL = 'SHADOW',
	ETYPE = 'CC',
	DURATION = 30,
}

-- Net O Matic
aurae.EFFECTS["Net-o-Matic"] = {
	ICON = 'INV_Misc_Net_01',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 10,
}

-- Rocket Helm
aurae.EFFECTS["Reckless Charge"] = {
	ICON = 'INV_Helmet_49',
	SCHOOL = 'PHYSICAL',
	ETYPE = 'CC',
	DURATION = 30,
}