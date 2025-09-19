module("modules.configs.excel2json.lua_activity194_option", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	optionResultId = 7,
	name = 2,
	effect = 6,
	optionRestriction = 5,
	conditionDesc = 3,
	optionDesc = 4,
	optionId = 1
}
local var_0_2 = {
	"optionId"
}
local var_0_3 = {
	conditionDesc = 2,
	name = 1,
	optionDesc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
