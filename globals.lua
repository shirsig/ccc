ETYPE_CC = 1
ETYPE_DEBUFF = 2
ETYPE_BUFF = 4

CTYPE_SCHOOL = 1
CTYPE_PROGRESS = 2
CTYPE_CUSTOM = 3

function QuickLocalize(str)
-- just remove $1 & $2 args because we *know that the order is not changed*.
-- not fail proof if ever it occurs (should be a more clever function, and return found arguments order)
	str = string.gsub(str, ".%$", "")
	str = string.gsub(str, "%%s", "\(.+\)")
	return str
end

function aurae_Globals()

aurae_Save = {}

aurae = {}
aurae.PROFILE = ""
aurae.COMBO = 0
aurae.STATUS = 0

aurae.INVERT = false
aurae.GROWTH = 0
aurae.SCALE = 1
aurae.WIDTH = 160
aurae.ALPHA = 1

aurae.VARIABLES_LOADED = false
aurae.VARIABLE_TIMER = 0

-- effect groups for each bar
aurae.GROUPSCC = {}
aurae.GROUPSDEBUFF = {}
aurae.GROUPSBUFF = {}

-- CC Durations according to rank
-- WARNING : in case of difference between skill and effect, separate strings have to be used.
-- (see Hunter 'Freeze Trap' for instance)

aurae_ACTIONS = {}
-- Warrior
aurae_ACTIONS[aurae_REND] = {
	RANKS = 7,
	DURATION = {9, 12, 15, 18, 21, 21, 21},
}

-- Mage
aurae_ACTIONS[aurae_POLYMORPH] = {
	RANKS = 4,
	DURATION = {20, 30, 40, 50},
}

aurae_ACTIONS[aurae_FIREBALL] = {
	RANKS = 11,
	DURATION = {4, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8},
}

aurae_ACTIONS[aurae_FROSTBOLT] = {
	RANKS = 10,
	DURATION = {5, 6, 6, 7, 7, 8, 8, 9, 9, 9},
	DELAY = .5,
}

-- Priest
aurae_ACTIONS[aurae_SHACKLE] = {
	RANKS = 3,
	DURATION = {30, 40, 50},
}

-- Druid
aurae_ACTIONS[aurae_ROOTS] = {
	RANKS = 6,
	DURATION = {12, 15, 18, 21, 24, 27},
}

aurae_ACTIONS[aurae_BASH] = {
	RANKS = 3,
	DURATION = {2, 3, 4},
}

aurae_ACTIONS[aurae_HIBERNATE] = {
	RANKS = 3,
	DURATION = {20, 30, 40},
}

-- Hunter
aurae_ACTIONS[aurae_FREEZINGTRAP_SPELL] = {
	RANKS = 3,
	DURATION = {10, 15, 20},
	EFFECTNAME = aurae_FREEZINGTRAP,
}

aurae_ACTIONS[aurae_SCAREBEAST] = {
	RANKS = 3,
	DURATION = {10, 15, 20},
}

-- Paladin
aurae_ACTIONS[aurae_HOJ] = {
	RANKS = 4,
	DURATION = {3, 4, 5, 6},
}

aurae_ACTIONS[aurae_TURNUNDEAD] = {
	RANKS = 3,
	DURATION = {10, 15, 20},
}

aurae_ACTIONS[aurae_DIVINESHIELD] = {
	RANKS = 2,
	DURATION = {10, 12},
}

-- Warlock
aurae_ACTIONS[aurae_FEAR] = {
	RANKS = 3,
	DURATION = {10, 15, 20},
}

aurae_ACTIONS[aurae_HOWLOFTERROR] = {
	RANKS = 2,
	DURATION = {10, 15},
}

aurae_ACTIONS[aurae_BANISH] = {
	RANKS = 2,
	DURATION = {20, 30},
}

aurae_ACTIONS[aurae_CORRUPTION] = {
	RANKS = 7,
	DURATION = {12, 15, 18, 18, 18, 18, 18},
}

-- Rogue
aurae_ACTIONS[aurae_SAP] = {
	RANKS = 3,
	DURATION = {25, 35, 45},
}

aurae_TEXT_ON = QuickLocalize(AURAADDEDOTHERHARMFUL)
aurae_TEXT_BREAK = QuickLocalize(AURADISPELOTHER)
aurae_TEXT_OFF = QuickLocalize(AURAREMOVEDOTHER)

aurae_TEXT_BUFF_ON = QuickLocalize(AURAADDEDOTHERHELPFUL)
end
