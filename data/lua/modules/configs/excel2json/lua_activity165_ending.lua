module("modules.configs.excel2json.lua_activity165_ending", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	text = 5,
	level = 6,
	pic = 7,
	endingText = 4,
	endingId = 1,
	finalStepId = 3,
	belongStoryId = 2
}
local var_0_2 = {
	"endingId"
}
local var_0_3 = {
	text = 2,
	endingText = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
