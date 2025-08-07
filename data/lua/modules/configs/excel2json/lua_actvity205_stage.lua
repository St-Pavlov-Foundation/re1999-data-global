module("modules.configs.excel2json.lua_actvity205_stage", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stageId = 2,
	name = 6,
	times = 5,
	targetDesc = 8,
	ruleTitle = 9,
	ruleDesc = 10,
	desc = 7,
	endTime = 4,
	icon = 11,
	activityId = 1,
	startTime = 3
}
local var_0_2 = {
	"activityId",
	"stageId"
}
local var_0_3 = {
	ruleTitle = 4,
	name = 1,
	ruleDesc = 5,
	targetDesc = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
