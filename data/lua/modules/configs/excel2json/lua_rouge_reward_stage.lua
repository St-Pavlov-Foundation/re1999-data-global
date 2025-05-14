module("modules.configs.excel2json.lua_rouge_reward_stage", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jump = 8,
	name = 6,
	icon = 5,
	stage = 2,
	season = 1,
	openTime = 9,
	bigRewardId = 4,
	pointLimit = 10,
	preStage = 3,
	lockName = 7
}
local var_0_2 = {
	"season",
	"stage"
}
local var_0_3 = {
	lockName = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
