module("modules.configs.excel2json.lua_character", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	actor = 28,
	name = 2,
	signature = 24,
	skinId = 4,
	career = 5,
	uniqueSkill_point = 12,
	nameEng = 23,
	characterTag = 22,
	heroType = 27,
	desc2 = 34,
	skill = 18,
	battleTag = 9,
	ai = 14,
	trust = 30,
	powerMax = 13,
	mvskinId = 35,
	roleBirthday = 29,
	useDesc = 33,
	duplicateItem = 16,
	rare = 6,
	resistance = 20,
	duplicateItem2 = 17,
	initials = 3,
	id = 1,
	gender = 8,
	desc = 32,
	equipRec = 10,
	dmgType = 7,
	birthdayBonus = 31,
	exSkill = 19,
	isOnline = 26,
	firstItem = 15,
	photoFrameBg = 25,
	school = 21,
	rank = 11
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc2 = 5,
	name = 1,
	useDesc = 4,
	characterTag = 2,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
