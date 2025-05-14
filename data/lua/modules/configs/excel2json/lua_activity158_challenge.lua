module("modules.configs.excel2json.lua_activity158_challenge", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	instructionDesc = 8,
	difficulty = 3,
	unlockCondition = 6,
	episodeId = 9,
	heroId = 7,
	id = 1,
	stage = 5,
	activityId = 2,
	sort = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	instructionDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
