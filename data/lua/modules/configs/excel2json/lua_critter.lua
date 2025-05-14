module("modules.configs.excel2json.lua_critter", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	eventTimes = 16,
	name = 2,
	rare = 3,
	specialRate = 12,
	banishBonus = 13,
	raceTag = 11,
	catalogue = 14,
	desc = 7,
	relation = 17,
	story = 19,
	attributeIncrRate = 9,
	foodLike = 15,
	icon = 6,
	trainTime = 10,
	mutateSkin = 5,
	line = 18,
	baseAttribute = 8,
	normalSkin = 4,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	line = 3,
	name = 1,
	story = 4,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
