module("modules.configs.excel2json.lua_trade_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	maxRestBuildingNum = 2,
	maxTrainSlotCount = 8,
	jobCard = 6,
	job = 5,
	dimension = 4,
	levelUpNeedTask = 7,
	trainsRoundCount = 9,
	unlockId = 10,
	addBlockMax = 3,
	silenceBonus = 11,
	bonus = 12,
	taskName = 13,
	level = 1
}
local var_0_2 = {
	"level"
}
local var_0_3 = {
	dimension = 1,
	taskName = 3,
	job = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
