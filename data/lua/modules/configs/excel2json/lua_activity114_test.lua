module("modules.configs.excel2json.lua_activity114_test", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	score = 8,
	topic = 4,
	result = 9,
	testId = 3,
	choice2 = 6,
	choice1 = 5,
	id = 2,
	activityId = 1,
	choice3 = 7
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	topic = 1,
	choice2 = 3,
	choice3 = 4,
	choice1 = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
