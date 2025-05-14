module("modules.configs.excel2json.lua_turnback", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	endStory = 8,
	name = 3,
	offlineDays = 4,
	monthCardAddedId = 19,
	additionRate = 14,
	additionType = 13,
	bonusPointMaterial = 18,
	durationDays = 6,
	endTime = 20,
	additionChapterIds = 15,
	buyDoubleBonusPrice = 22,
	bindActivityId = 2,
	taskBonusMailId = 9,
	startStory = 7,
	canBuyDoubleBonus = 21,
	bonusList = 23,
	jumpId = 16,
	priority = 17,
	onlineDurationDays = 24,
	additionDurationDays = 12,
	condition = 5,
	onceBonus = 11,
	id = 1,
	subModuleIds = 10
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
