module("modules.configs.excel2json.lua_critter_train_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	roomDialogId = 12,
	name = 3,
	skilledStoryId = 11,
	type = 2,
	normalStoryId = 10,
	autoFinish = 14,
	content = 17,
	desc = 8,
	preferenceAttribute = 6,
	computeIncrRate = 13,
	maxCount = 15,
	effectAttribute = 9,
	cost = 16,
	addAttribute = 5,
	condition = 4,
	initStoryId = 7,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	content = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
