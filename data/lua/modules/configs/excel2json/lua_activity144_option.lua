﻿module("modules.configs.excel2json.lua_activity144_option", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activityId = 1,
	name = 5,
	optionResults = 4,
	conditionDesc = 3,
	optionDesc = 6,
	optionId = 2
}
local var_0_2 = {
	"activityId",
	"optionId"
}
local var_0_3 = {
	conditionDesc = 1,
	name = 2,
	optionDesc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
