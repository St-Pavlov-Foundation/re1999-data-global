module("modules.configs.excel2json.lua_rouge_reward", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stage = 4,
	value = 6,
	preId = 3,
	type = 7,
	season = 1,
	offset = 11,
	pos = 5,
	rewardName = 9,
	rewardType = 10,
	id = 2,
	icon = 8
}
local var_0_2 = {
	"season",
	"id"
}
local var_0_3 = {
	rewardName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
