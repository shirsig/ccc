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

function CCWatch_Globals()

CCWatch_Save = {}

CCWATCH = {}
CCWATCH.PROFILE = ""
CCWATCH.COMBO = 0
CCWATCH.STATUS = 0

CCWATCH.INVERT = false
CCWATCH.GROWTH = 0
CCWATCH.SCALE = 1
CCWATCH.WIDTH = 160
CCWATCH.ALPHA = 1

CCWATCH.VARIABLES_LOADED = false
CCWATCH.VARIABLE_TIMER = 0

-- effect groups for each bar
CCWATCH.GROUPSCC = {}
CCWATCH.GROUPSDEBUFF = {}
CCWATCH.GROUPSBUFF = {}

-- CC Durations according to rank
-- WARNING : in case of difference between skill and effect, separate strings have to be used.
-- (see Hunter 'Freeze Trap' for instance)

CCWATCH_ACTIONS = {}
-- Warrior
CCWATCH_ACTIONS[CCWATCH_REND] = {
	RANKS = 7,
	DURATION = {9, 12, 15, 18, 21, 21, 21},
}

-- Mage
CCWATCH_ACTIONS[CCWATCH_POLYMORPH] = {
	RANKS = 4,
	DURATION = {20, 30, 40, 50},
}

CCWATCH_ACTIONS[CCWATCH_FIREBALL] = {
	RANKS = 11,
	DURATION = {4, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8},
}

CCWATCH_ACTIONS[CCWATCH_FROSTBOLT] = {
	RANKS = 10,
	DURATION = {5, 6, 6, 7, 7, 8, 8, 9, 9, 9},
	DELAY = .5,
}

-- Priest
CCWATCH_ACTIONS[CCWATCH_SHACKLE] = {
	RANKS = 3,
	DURATION = {30, 40, 50},
}

-- Druid
CCWATCH_ACTIONS[CCWATCH_ROOTS] = {
	RANKS = 6,
	DURATION = {12, 15, 18, 21, 24, 27},
}

CCWATCH_ACTIONS[CCWATCH_BASH] = {
	RANKS = 3,
	DURATION = {2, 3, 4},
}

CCWATCH_ACTIONS[CCWATCH_HIBERNATE] = {
	RANKS = 3,
	DURATION = {20, 30, 40},
}

-- Hunter
CCWATCH_ACTIONS[CCWATCH_FREEZINGTRAP_SPELL] = {
	RANKS = 3,
	DURATION = {10, 15, 20},
	EFFECTNAME = CCWATCH_FREEZINGTRAP,
}

CCWATCH_ACTIONS[CCWATCH_SCAREBEAST] = {
	RANKS = 3,
	DURATION = {10, 15, 20},
}

-- Paladin
CCWATCH_ACTIONS[CCWATCH_HOJ] = {
	RANKS = 4,
	DURATION = {3, 4, 5, 6},
}

CCWATCH_ACTIONS[CCWATCH_TURNUNDEAD] = {
	RANKS = 3,
	DURATION = {10, 15, 20},
}

CCWATCH_ACTIONS[CCWATCH_DIVINESHIELD] = {
	RANKS = 2,
	DURATION = {10, 12},
}

-- Warlock
CCWATCH_ACTIONS[CCWATCH_FEAR] = {
	RANKS = 3,
	DURATION = {10, 15, 20},
}

CCWATCH_ACTIONS[CCWATCH_HOWLOFTERROR] = {
	RANKS = 2,
	DURATION = {10, 15},
}

CCWATCH_ACTIONS[CCWATCH_BANISH] = {
	RANKS = 2,
	DURATION = {20, 30},
}

CCWATCH_ACTIONS[CCWATCH_CORRUPTION] = {
	RANKS = 7,
	DURATION = {12, 15, 18, 18, 18, 18, 18},
}

-- Rogue
CCWATCH_ACTIONS[CCWATCH_SAP] = {
	RANKS = 3,
	DURATION = {25, 35, 45},
}

CCWATCH_TEXT_ON = QuickLocalize(AURAADDEDOTHERHARMFUL)
CCWATCH_TEXT_BREAK = QuickLocalize(AURADISPELOTHER)
CCWATCH_TEXT_OFF = QuickLocalize(AURAREMOVEDOTHER)

CCWATCH_TEXT_BUFF_ON = QuickLocalize(AURAADDEDOTHERHELPFUL)
CCWATCH_TEXT_DIE = QuickLocalize(UNITDIESOTHER)
CCWATCH_TEXT_DIEXP = strsub(CCWATCH_TEXT_DIE, 1, -2) .. ".+"
end
