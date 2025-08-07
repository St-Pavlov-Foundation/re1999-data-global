module("modules.configs.excel2json.lua_activity206_desc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stageId = 2,
	name = 3,
	targetDesc = 5,
	ruleTitle = 6,
	ruleDesc = 7,
	icon = 8,
	activityId = 1,
	desc = 4
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
