module("modules.configs.excel2json.lua_activity165_step", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	text = 6,
	stepId = 1,
	answersKeywordIds = 4,
	nextStepConditionIds = 5,
	optionalKeywordIds = 3,
	pic = 7,
	belongStoryId = 2
}
local var_0_2 = {
	"stepId"
}
local var_0_3 = {
	text = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
