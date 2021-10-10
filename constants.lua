setfenv(1, setmetatable(select(2, ...), { __index = _G }))

SPELL_EFFECTS = {
	[1168] = {118}, -- Polymorph (Rank 1)
	[12827] = {12824}, -- Polymorph (Rank 2)
	[12828] = {12825}, -- Polymorph (Rank 3)
	[12829] = {12826}, -- Polymorph (Rank 4)
	[28286] = {28271}, -- Polymorph: Turtle
	[28285] = {28272}, -- Polymorph: Pig
	[16979] = {19675}, -- Feral Charge
	[5246] = {20511}, -- Intimidating Shout
	[20252] = {20253}, -- Intercept (Rank 1)
	[20616] = {20614}, -- Intercept (Rank 2)
	[20617] = {20615}, -- Intercept (Rank 3)
	[22641] = {13327}, -- Reckless Charge
	[1499] = {3355}, -- Freezing Trap (Rank 1)
	[14310] = {14308}, -- Freezing Trap (Rank 2)
	[14311] = {14309}, -- Freezing Trap (Rank 3)
	[9005] = {9005, 9007}, -- Pounce (Rank 1)
	[9823] = {9823, 9824}, -- Pounce (Rank 2)
	[9827] = {9827, 9826}, -- Pounce (Rank 3)
	[16689] = {19975}, -- Nature's Grasp (Rank 1)
	[16810] = {19974}, -- Nature's Grasp (Rank 2)
	[16811] = {19973}, -- Nature's Grasp (Rank 3)
	[16812] = {19972}, -- Nature's Grasp (Rank 4)
	[16813] = {19971}, -- Nature's Grasp (Rank 5)
	[17329] = {19970}, -- Nature's Grasp (Rank 6)
}

DURATION = {
	[14251] = 6, -- Riposte
	[116] = 5, -- Frostbolt (Rank 1)
	[205] = 6, -- Frostbolt (Rank 2)
	[837] = 6, -- Frostbolt (Rank 3)
	[7322] = 7, -- Frostbolt (Rank 4)
	[8406] = 7, -- Frostbolt (Rank 5)
	[8407] = 8, -- Frostbolt (Rank 6)
	[8408] = 8, -- Frostbolt (Rank 7)
	[10179] = 9, -- Frostbolt (Rank 8)
	[10180] = 9, -- Frostbolt (Rank 9)
	[10181] = 9, -- Frostbolt (Rank 10)
	[25304] = 9, -- Frostbolt (Rank 11)
	[120] = 8, -- Cone of Cold (Rank 1)
	[8492] = 8, -- Cone of Cold (Rank 2)
	[10159] = 8, -- Cone of Cold (Rank 3)
	[10160] = 8, -- Cone of Cold (Rank 4)
	[10161] = 8, -- Cone of Cold (Rank 5)
	[11113] = 6, -- Blast Wave (Rank 1)
	[13018] = 6, -- Blast Wave (Rank 2)
	[13019] = 6, -- Blast Wave (Rank 3)
	[13020] = 6, -- Blast Wave (Rank 4)
	[13021] = 6, -- Blast Wave (Rank 5)
	[2974] = 10, -- Wing Clip (Rank 1)
	[14267] = 10, -- Wing Clip (Rank 2)
	[14268] = 10, -- Wing Clip (Rank 3)
	[18223] = 12, -- Curse of Exhaustion
	[1714] = 30, -- Curse of Tongues (Rank 1)
	[11719] = 30, -- Curse of Tongues (Rank 2)
	[676] = 10, -- Disarm
	[12294] = 10, -- Mortal Strike (Rank 1)
	[21551] = 10, -- Mortal Strike (Rank 2)
	[21552] = 10, -- Mortal Strike (Rank 3)
	[21553] = 10, -- Mortal Strike (Rank 4)
	[1715] = 15, -- Hamstring (Rank 1)
	[7372] = 15, -- Hamstring (Rank 2)
	[7373] = 15, -- Hamstring (Rank 3)
	[12323] = 6, -- Piercing Howl
	[8056] = 8, -- Frost Shock (Rank 1)
	[8058] = 8, -- Frost Shock (Rank 2)
	[10472] = 8, -- Frost Shock (Rank 3)
	[10473] = 8, -- Frost Shock (Rank 4)
	[8050] = 12, -- Flame Shock (Rank 1)
	[8052] = 12, -- Flame Shock (Rank 2)
	[8053] = 12, -- Flame Shock (Rank 3)
	[10447] = 12, -- Flame Shock (Rank 4)
	[10448] = 12, -- Flame Shock (Rank 5)
	[29228] = 12, -- Flame Shock (Rank 6)
	[1776] = 4, -- Gouge (Rank 1)
	[1777] = 4, -- Gouge (Rank 2)
	[8629] = 4, -- Gouge (Rank 3)
	[11285] = 4, -- Gouge (Rank 4)
	[11286] = 4, -- Gouge (Rank 5)
	[2094] = 10, -- Blind
	[6770] = 25, -- Sap (Rank 1)
	[2070] = 35, -- Sap (Rank 2)
	[11297] = 45, -- Sap (Rank 3)
	[408] = 0, -- Kidney Shot (Rank 1)
	[8643] = 1, -- Kidney Shot (Rank 2)
	[1833] = 4, -- Cheap Shot
	[9484] = 30, -- Shackle Undead (Rank 1)
	[9485] = 40, -- Shackle Undead (Rank 2)
	[10955] = 50, -- Shackle Undead (Rank 3)
	[8122] = 8, -- Psychic Scream (Rank 1)
	[8124] = 8, -- Psychic Scream (Rank 2)
	[10888] = 8, -- Psychic Scream (Rank 3)
	[10890] = 8, -- Psychic Scream (Rank 4)
	[118] = 20, -- Polymorph (Rank 1)
	[12824] = 30, -- Polymorph (Rank 2)
	[12825] = 40, -- Polymorph (Rank 3)
	[12826] = 50, -- Polymorph (Rank 4)
	[28271] = 50, -- Polymorph: Turtle
	[28272] = 50, -- Polymorph: Pig
	[122] = 8, -- Frost Nova (Rank 1)
	[865] = 8, -- Frost Nova (Rank 2)
	[6131] = 8, -- Frost Nova (Rank 3)
	[10230] = 8, -- Frost Nova (Rank 4)
	[339] = 12, -- Entangling Roots (Rank 1)
	[1062] = 15, -- Entangling Roots (Rank 2)
	[5195] = 18, -- Entangling Roots (Rank 3)
	[5196] = 21, -- Entangling Roots (Rank 4)
	[9852] = 24, -- Entangling Roots (Rank 5)
	[9853] = 27, -- Entangling Roots (Rank 6)
	[19975] = 12, -- Nature's Grasp (Rank 1)
	[19974] = 15, -- Nature's Grasp (Rank 2)
	[19973] = 18, -- Nature's Grasp (Rank 3)
	[19972] = 21, -- Nature's Grasp (Rank 4)
	[19971] = 24, -- Nature's Grasp (Rank 5)
	[19970] = 27, -- Nature's Grasp (Rank 6)
	[2637] = 20, -- Hibernate (Rank 1)
	[18657] = 30, -- Hibernate (Rank 2)
	[18658] = 40, -- Hibernate (Rank 3)
	[19675] = 4, -- Feral Charge
	[9005] = 2, -- Pounce (Rank 1)
	[9823] = 2, -- Pounce (Rank 2)
	[9827] = 2, -- Pounce (Rank 3)
	[9007] = 18, -- Pounce Bleed (Rank 1)
	[9824] = 18, -- Pounce Bleed (Rank 2)
	[9826] = 18, -- Pounce Bleed (Rank 3)
	[5211] = 2, -- Bash (Rank 1)
	[6798] = 3, -- Bash (Rank 2)
	[8983] = 4, -- Bash (Rank 3)
	[1513] = 10, -- Scare Beast (Rank 1)
	[14326] = 15, -- Scare Beast (Rank 2)
	[14327] = 20, -- Scare Beast (Rank 3)
	[19503] = 4, -- Scatter Shot
	[3355] = 10, -- Freezing Trap Effect (Rank 1)
	[14308] = 15, -- Freezing Trap Effect (Rank 2)
	[14309] = 20, -- Freezing Trap Effect (Rank 3)
	[19386] = 12, -- Wyvern Sting (Rank 1)
	[24132] = 12, -- Wyvern Sting (Rank 2)
	[24133] = 12, -- Wyvern Sting (Rank 3)
	[1978] = 15, -- Serpent Sting (Rank 1)
	[13549] = 15, -- Serpent Sting (Rank 2)
	[13550] = 15, -- Serpent Sting (Rank 3)
	[13551] = 15, -- Serpent Sting (Rank 4)
	[13552] = 15, -- Serpent Sting (Rank 5)
	[13553] = 15, -- Serpent Sting (Rank 6)
	[13554] = 15, -- Serpent Sting (Rank 7)
	[13555] = 15, -- Serpent Sting (Rank 8)
	[25295] = 15, -- Serpent Sting (Rank 9)
	[3034] = 8, -- Viper Sting (Rank 1)
	[14279] = 8, -- Viper Sting (Rank 2)
	[14280] = 8, -- Viper Sting (Rank 3)
	[5116] = 4, -- Concussive Shot
	[19306] = 5, -- Counterattack (Rank 1)
	[20909] = 5, -- Counterattack (Rank 2)
	[20910] = 5, -- Counterattack (Rank 3)
	[853] = 3, -- Hammer of Justice (Rank 1)
	[5588] = 4, -- Hammer of Justice (Rank 2)
	[5589] = 5, -- Hammer of Justice (Rank 3)
	[10308] = 6, -- Hammer of Justice (Rank 4)
	[20066] = 6, -- Repentance
	[2878] = 10, -- Turn Undead (Rank 1)
	[5627] = 15, -- Turn Undead (Rank 2)
	[10326] = 20, -- Turn Undead (Rank 3)
	[5782] = 10, -- Fear (Rank 1)
	[6213] = 15, -- Fear (Rank 2)
	[6215] = 20, -- Fear (Rank 3)
	[5484] = 10, -- Howl of Terror (Rank 1)
	[17928] = 15, -- Howl of Terror (Rank 2)
	[6789] = 3, -- Death Coil (Rank 1)
	[17925] = 3, -- Death Coil (Rank 2)
	[17926] = 3, -- Death Coil (Rank 3)
	[710] = 20, -- Banish (Rank 1)
	[18647] = 30, -- Banish (Rank 2)
	[20511] = 8, -- Intimidating Shout
	[12809] = 5, -- Concussion Blow
	[20549] = 2, -- War Stomp
	[20253] = 3, -- Intercept (Rank 1)
	[20614] = 3, -- Intercept (Rank 2)
	[20615] = 3, -- Intercept (Rank 3)
	[15487] = 5, -- Silence
	[1098] = 300, -- Enslave Demon (Rank 1)
	[11725] = 300, -- Enslave Demon (Rank 2)
	[11726] = 300, -- Enslave Demon (Rank 3)
	[605] = 60, -- Mind Control (Rank 1)
	[10911] = 60, -- Mind Control (Rank 2)
	[10912] = 60, -- Mind Control (Rank 3)
	[26740] = 20, -- Gnomish Mind Control Cap
	[13327] = 30, -- Reckless Charge
	[700] = 20, -- Sleep (Rank 1)
	[1090] = 30, -- Sleep (Rank 2)
	[8312] = 10, -- Trap
	[13120] = 10, -- Net-o-Matic
	[835] = 3, -- Tidal Charm
	[703] = 18, -- Garrote (Rank 1)
	[8631] = 18, -- Garrote (Rank 2)
	[8632] = 18, -- Garrote (Rank 3)
	[8633] = 18, -- Garrote (Rank 4)
	[11289] = 18, -- Garrote (Rank 5)
	[11290] = 18, -- Garrote (Rank 6)
	[1943] = 6, -- Rupture (Rank 1)
	[8639] = 6, -- Rupture (Rank 2)
	[8640] = 6, -- Rupture (Rank 3)
	[11273] = 6, -- Rupture (Rank 4)
	[11274] = 6, -- Rupture (Rank 5)
	[11275] = 6, -- Rupture (Rank 6)
	[980] = 24, -- Curse of Agony (Rank 1)
	[1014] = 24, -- Curse of Agony (Rank 2)
	[6217] = 24, -- Curse of Agony (Rank 3)
	[11711] = 24, -- Curse of Agony (Rank 4)
	[11712] = 24, -- Curse of Agony (Rank 5)
	[11713] = 24, -- Curse of Agony (Rank 6)
	[172] = 12, -- Corruption (Rank 1)
	[6222] = 15, -- Corruption (Rank 2)
	[6223] = 18, -- Corruption (Rank 3)
	[7648] = 18, -- Corruption (Rank 4)
	[11671] = 18, -- Corruption (Rank 5)
	[11672] = 18, -- Corruption (Rank 6)
	[25311] = 18, -- Corruption (Rank 7)
	[348] = 15, -- Immolate (Rank 1)
	[707] = 15, -- Immolate (Rank 2)
	[1094] = 15, -- Immolate (Rank 3)
	[2941] = 15, -- Immolate (Rank 4)
	[11665] = 15, -- Immolate (Rank 5)
	[11667] = 15, -- Immolate (Rank 6)
	[11668] = 15, -- Immolate (Rank 7)
	[25309] = 15, -- Immolate (Rank 8)
	[18265] = 30, -- Siphon Life (Rank 1)
	[18879] = 30, -- Siphon Life (Rank 2)
	[18880] = 30, -- Siphon Life (Rank 3)
	[18881] = 30, -- Siphon Life (Rank 4)
	[2944] = 24, -- Devouring Plague (Rank 1)
	[19276] = 24, -- Devouring Plague (Rank 2)
	[19277] = 24, -- Devouring Plague (Rank 3)
	[19278] = 24, -- Devouring Plague (Rank 4)
	[19279] = 24, -- Devouring Plague (Rank 5)
	[19280] = 24, -- Devouring Plague (Rank 6)
	[589] = 18, -- Shadow Word: Pain (Rank 1)
	[594] = 18, -- Shadow Word: Pain (Rank 2)
	[970] = 18, -- Shadow Word: Pain (Rank 3)
	[992] = 18, -- Shadow Word: Pain (Rank 4)
	[2767] = 18, -- Shadow Word: Pain (Rank 5)
	[10892] = 18, -- Shadow Word: Pain (Rank 6)
	[10893] = 18, -- Shadow Word: Pain (Rank 7)
	[10894] = 18, -- Shadow Word: Pain (Rank 8)
	[8921] = 12, -- Moonfire (Rank 1)
	[8924] = 12, -- Moonfire (Rank 2)
	[8925] = 12, -- Moonfire (Rank 3)
	[8926] = 12, -- Moonfire (Rank 4)
	[8927] = 12, -- Moonfire (Rank 5)
	[8928] = 12, -- Moonfire (Rank 6)
	[8929] = 12, -- Moonfire (Rank 7)
	[9833] = 12, -- Moonfire (Rank 8)
	[9834] = 12, -- Moonfire (Rank 9)
	[9835] = 12, -- Moonfire (Rank 10)
	[5570] = 12, -- Insect Swarm (Rank 1)
	[24974] = 12, -- Insect Swarm (Rank 2)
	[24975] = 12, -- Insect Swarm (Rank 3)
	[24976] = 12, -- Insect Swarm (Rank 4)
	[24977] = 12, -- Insect Swarm (Rank 5)
	[1822] = 9, -- Rake (Rank 1)
	[1823] = 9, -- Rake (Rank 2)
	[1824] = 9, -- Rake (Rank 3)
	[9904] = 9, -- Rake (Rank 4)
	[1079] = 12, -- Rip (Rank 1)
	[9492] = 12, -- Rip (Rank 2)
	[9493] = 12, -- Rip (Rank 3)
	[9752] = 12, -- Rip (Rank 4)
	[9894] = 12, -- Rip (Rank 5)
	[9896] = 12, -- Rip (Rank 6)
	[770] = 40, -- Faerie Fire (Rank 1)
	[778] = 40, -- Faerie Fire (Rank 2)
	[9749] = 40, -- Faerie Fire (Rank 3)
	[9907] = 40, -- Faerie Fire (Rank 4)
	[16857] = 40, -- Faerie Fire (Feral) (Rank 1)
	[17390] = 40, -- Faerie Fire (Feral) (Rank 2)
	[17391] = 40, -- Faerie Fire (Feral) (Rank 3)
	[17392] = 40, -- Faerie Fire (Feral) (Rank 4)
    [1160] = 30, -- Demoralizing Shout (Rank 1)
    [6190] = 30, -- Demoralizing Shout (Rank 2)
    [11554] = 30, -- Demoralizing Shout (Rank 3)
    [11555] = 30, -- Demoralizing Shout (Rank 4)
    [11556] = 30, -- Demoralizing Shout (Rank 5)
    [99] = 30, -- Demoralizing Roar (Rank 1)
    [1735] = 30, -- Demoralizing Roar (Rank 2)
    [9490] = 30, -- Demoralizing Roar (Rank 3)
    [9747] = 30, -- Demoralizing Roar (Rank 4)
    [9898] = 30, -- Demoralizing Roar (Rank 5)
}

AOE = {
	[120] = true, -- Cone of Cold (Rank 1)
	[8492] = true, -- Cone of Cold (Rank 2)
	[10159] = true, -- Cone of Cold (Rank 3)
	[10160] = true, -- Cone of Cold (Rank 4)
	[10161] = true, -- Cone of Cold (Rank 5)
	[11113] = true, -- Blast Wave (Rank 1)
	[13018] = true, -- Blast Wave (Rank 2)
	[13019] = true, -- Blast Wave (Rank 3)
	[13020] = true, -- Blast Wave (Rank 4)
	[13021] = true, -- Blast Wave (Rank 5)
	[12323] = true, -- Piercing Howl
	[8122] = true, -- Psychic Scream (Rank 1)
	[8124] = true, -- Psychic Scream (Rank 2)
	[10888] = true, -- Psychic Scream (Rank 3)
	[10890] = true, -- Psychic Scream (Rank 4)
	[122] = true, -- Frost Nova (Rank 1)
	[865] = true, -- Frost Nova (Rank 2)
	[6131] = true, -- Frost Nova (Rank 3)
	[10230] = true, -- Frost Nova (Rank 4)
	[5484] = true, -- Howl of Terror (Rank 1)
	[17928] = true, -- Howl of Terror (Rank 2)
	[20549] = true, -- War Stomp
}

SPECIAL_EVENT = { -- TODO perhaps this is not needed anymore for stealth spells
	[9005] = true, -- Pounce (Rank 1)
	[9823] = true, -- Pounce (Rank 2)
	[9827] = true, -- Pounce (Rank 3)
	[9007] = true, -- Pounce Bleed (Rank 1)
	[9824] = true, -- Pounce Bleed (Rank 2)
	[9826] = true, -- Pounce Bleed (Rank 3)
	[1833] = true, -- Cheap Shot
	[6770] = true, -- Sap (Rank 1)
	[2070] = true, -- Sap (Rank 2)
	[11297] = true, -- Sap (Rank 3)
	[703] = true, -- Garrote (Rank 1)
	[8631] = true, -- Garrote (Rank 2)
	[8632] = true, -- Garrote (Rank 3)
	[8633] = true, -- Garrote (Rank 4)
	[11289] = true, -- Garrote (Rank 5)
	[11290] = true, -- Garrote (Rank 6)
	[1499] = true, -- Freezing Trap (Rank 1)
	[14310] = true, -- Freezing Trap (Rank 2)
	[14311] = true, -- Freezing Trap (Rank 3)
}

OOC = {
	[1098] = true, -- Enslave Demon (Rank 1)
	[11725] = true, -- Enslave Demon (Rank 2)
	[11726] = true, -- Enslave Demon (Rank 3)
	[605] = true, -- Mind Control (Rank 1)
	[10911] = true, -- Mind Control (Rank 2)
	[10912] = true, -- Mind Control (Rank 3)
	[26740] = true, -- Gnomish Mind Control Cap
}

COMBO = {
	[408] = 1, -- Kidney Shot (Rank 1)
	[8643] = 1, -- Kidney Shot (Rank 2)
	[1943] = 2, -- Rupture (Rank 1)
	[8639] = 2, -- Rupture (Rank 2)
	[8640] = 2, -- Rupture (Rank 3)
	[11273] = 2, -- Rupture (Rank 4)
	[11274] = 2, -- Rupture (Rank 5)
	[11275] = 2, -- Rupture (Rank 6)
}

local function talentRank(i, j)
	local _, _, _, _, rank = GetTalentInfo(i, j)
	return rank
end

do
	local BONUS_FUNCTIONS = {
		gouge = function()
			return talentRank(2, 1) * .5
		end,
		cone_of_cold = function()
			return min(1, talentRank(3, 7)) * .5 + talentRank(3, 7) * .5
		end,
		frostbolt = function()
			return min(1, talentRank(3, 7)) * .5 + talentRank(3, 7) * .5
		end,
		pounce = function()
			return talentRank(2, 4) * .5
		end,
		bash = function()
			return talentRank(2, 4) * .5
		end,
		freezing_trap_effect = function(duration)
			return duration * talentRank(3, 7) * .15
		end,
		shadow_word_pain = function()
			return talentRank(3, 4) * 3
		end,
	}

	BONUS = {
		[1776] = BONUS_FUNCTIONS.gouge, -- Gouge (Rank 1)
		[1777] = BONUS_FUNCTIONS.gouge, -- Gouge (Rank 2)
		[8629] = BONUS_FUNCTIONS.gouge, -- Gouge (Rank 3)
		[11285] = BONUS_FUNCTIONS.gouge, -- Gouge (Rank 4)
		[11286] = BONUS_FUNCTIONS.gouge, -- Gouge (Rank 5)
		[120] = BONUS_FUNCTIONS.cone_of_cold, -- Cone of Cold (Rank 1)
		[8492] = BONUS_FUNCTIONS.cone_of_cold, -- Cone of Cold (Rank 2)
		[10159] = BONUS_FUNCTIONS.cone_of_cold, -- Cone of Cold (Rank 3)
		[10160] = BONUS_FUNCTIONS.cone_of_cold, -- Cone of Cold (Rank 4)
		[10161] = BONUS_FUNCTIONS.cone_of_cold, -- Cone of Cold (Rank 5)
		[116] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 1)
		[205] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 2)
		[837] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 3)
		[7322] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 4)
		[8406] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 5)
		[8407] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 6)
		[8408] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 7)
		[10179] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 8)
		[10180] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 9)
		[10181] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 10)
		[25304] = BONUS_FUNCTIONS.frostbolt, -- Frostbolt (Rank 11)
		[9005] = BONUS_FUNCTIONS.pounce, -- Pounce (Rank 1)
		[9823] = BONUS_FUNCTIONS.pounce, -- Pounce (Rank 2)
		[9827] = BONUS_FUNCTIONS.pounce, -- Pounce (Rank 3)
		[5211] = BONUS_FUNCTIONS.bash, -- Bash (Rank 1)
		[6798] = BONUS_FUNCTIONS.bash, -- Bash (Rank 2)
		[8983] = BONUS_FUNCTIONS.bash, -- Bash (Rank 3)
		[3355] = BONUS_FUNCTIONS.freezing_trap_effect, -- Freezing Trap (Rank 1)
		[14308] = BONUS_FUNCTIONS.freezing_trap_effect, -- Freezing Trap (Rank 2)
		[14309] = BONUS_FUNCTIONS.freezing_trap_effect, -- Freezing Trap (Rank 3)
		[589] = BONUS_FUNCTIONS.shadow_word_pain, -- Shadow Word: Pain (Rank 1)
		[594] = BONUS_FUNCTIONS.shadow_word_pain, -- Shadow Word: Pain (Rank 2)
		[970] = BONUS_FUNCTIONS.shadow_word_pain, -- Shadow Word: Pain (Rank 3)
		[992] = BONUS_FUNCTIONS.shadow_word_pain, -- Shadow Word: Pain (Rank 4)
		[2767] = BONUS_FUNCTIONS.shadow_word_pain, -- Shadow Word: Pain (Rank 5)
		[10892] = BONUS_FUNCTIONS.shadow_word_pain, -- Shadow Word: Pain (Rank 6)
		[10893] = BONUS_FUNCTIONS.shadow_word_pain, -- Shadow Word: Pain (Rank 7)
		[10894] = BONUS_FUNCTIONS.shadow_word_pain, -- Shadow Word: Pain (Rank 8)
	}
end

DR_CLASS = {
	[5782] = 1, -- Fear (Rank 1)
	[6213] = 1, -- Fear (Rank 2)
	[6215] = 1, -- Fear (Rank 3)
	[5484] = 1, -- Howl of Terror (Rank 1)
	[17928] = 1, -- Howl of Terror (Rank 2)
	[6358] = 1, -- Seduction

	[118] = 2, -- Polymorph (Rank 1)
	[12824] = 2, -- Polymorph (Rank 2)
	[12825] = 2, -- Polymorph (Rank 3)
	[12826] = 2, -- Polymorph (Rank 4)
	[28271] = 2, -- Polymorph: Turtle
	[28272] = 2, -- Polymorph: Pig

	[3355] = 3, -- Freezing Trap Effect (Rank 1)
	[14308] = 3, -- Freezing Trap Effect (Rank 2)
	[14309] = 3, -- Freezing Trap Effect (Rank 3)
	[19386] = 3, -- Wyvern Sting (Rank 1)
	[24132] = 3, -- Wyvern Sting (Rank 2)
	[24133] = 3, -- Wyvern Sting (Rank 3)
	[19503] = 3, -- Scatter Shot

	[6770] = 4, -- Sap (Rank 1)
	[2070] = 4, -- Sap (Rank 2)
	[11297] = 4, -- Sap (Rank 3)
	[1776] = 4, -- Gouge (Rank 1)
	[1777] = 4, -- Gouge (Rank 2)
	[8629] = 4, -- Gouge (Rank 3)
	[11285] = 4, -- Gouge (Rank 4)
	[11286] = 4, -- Gouge (Rank 5)

	[1513] = 5, -- Scare Beast (Rank 1)
	[14326] = 5, -- Scare Beast (Rank 2)
	[14327] = 5, -- Scare Beast (Rank 3)

	[339] = 6, -- Entangling Roots (Rank 1)
	[1062] = 6, -- Entangling Roots (Rank 2)
	[5195] = 6, -- Entangling Roots (Rank 3)
	[5196] = 6, -- Entangling Roots (Rank 4)
	[9852] = 6, -- Entangling Roots (Rank 5)
	[9853] = 6, -- Entangling Roots (Rank 6)
	[19975] = 6, -- Nature's Grasp (Rank 1)
	[19974] = 6, -- Nature's Grasp (Rank 2)
	[19973] = 6, -- Nature's Grasp (Rank 3)
	[19972] = 6, -- Nature's Grasp (Rank 4)
	[19971] = 6, -- Nature's Grasp (Rank 5)
	[19970] = 6, -- Nature's Grasp (Rank 6)

	[122] = 7, -- Frost Nova (Rank 1)
	[865] = 7, -- Frost Nova (Rank 2)
	[6131] = 7, -- Frost Nova (Rank 3)
	[10230] = 7, -- Frost Nova (Rank 4)
	[12494] = 7, -- Frostbite (Rank 1)

	[1833] = 8, -- Cheap Shot

	[408] = 9, -- Kidney Shot (Rank 1)
	[8643] = 9, -- Kidney Shot (Rank 2)

	[2094] = 10, -- Blind

	[2637] = 11, -- Hibernate (Rank 1)
	[18657] = 11, -- Hibernate (Rank 2)
	[18658] = 11, -- Hibernate (Rank 3)

	[8056] = 12, -- Frost Shock (Rank 1)
	[8058] = 12, -- Frost Shock (Rank 2)
	[10472] = 12, -- Frost Shock (Rank 3)
	[10473] = 12, -- Frost Shock (Rank 4)
}

UNIQUENESS_CLASS = {
	[118] = 1, -- Polymorph (Rank 1)
	[12824] = 1, -- Polymorph (Rank 2)
	[12825] = 1, -- Polymorph (Rank 3)
	[12826] = 1, -- Polymorph (Rank 4)
	[28271] = 1, -- Polymorph: Turtle
	[28272] = 1, -- Polymorph: Pig

	[5782] = 2, -- Fear (Rank 1)
	[6213] = 2, -- Fear (Rank 2)
	[6215] = 2, -- Fear (Rank 3)

	[6770] = 3, -- Sap (Rank 1)
	[2070] = 3, -- Sap (Rank 2)
	[11297] = 3, -- Sap (Rank 3)

	[339] = 4, -- Entangling Roots (Rank 1)
	[1062] = 4, -- Entangling Roots (Rank 2)
	[5195] = 4, -- Entangling Roots (Rank 3)
	[5196] = 4, -- Entangling Roots (Rank 4)
	[9852] = 4, -- Entangling Roots (Rank 5)
	[9853] = 4, -- Entangling Roots (Rank 6)

	[2637] = 5, -- Hibernate (Rank 1)
	[18657] = 5, -- Hibernate (Rank 2)
	[18658] = 5, -- Hibernate (Rank 3)

	[2878] = 6, -- Turn Undead (Rank 1)
	[5627] = 6, -- Turn Undead (Rank 2)
	[10326] = 6, -- Turn Undead (Rank 3)

	[9484] = 7, -- Shackle Undead (Rank 1)
	[9485] = 7, -- Shackle Undead (Rank 2)
	[10955] = 7, -- Shackle Undead (Rank 3)

	[710] = 8, -- Banish (Rank 1)
	[18647] = 8, -- Banish (Rank 2)

	[1513] = 9, -- Scare Beast (Rank 1)
	[14326] = 9, -- Scare Beast (Rank 2)
	[14327] = 9, -- Scare Beast (Rank 3)

	[1098] = 10, -- Enslave Demon (Rank 1)
	[11725] = 10, -- Enslave Demon (Rank 2)
	[11726] = 10, -- Enslave Demon (Rank 3)

	[605] = 11, -- Mind Control (Rank 1)
	[10911] = 11, -- Mind Control (Rank 2)
	[10912] = 11, -- Mind Control (Rank 3)

	[26740] = 12, -- Gnomish Mind Control Cap

	[3034] = 13, -- Viper Sting (Rank 1)
	[14279] = 13, -- Viper Sting (Rank 2)
	[14280] = 13, -- Viper Sting (Rank 3)
}