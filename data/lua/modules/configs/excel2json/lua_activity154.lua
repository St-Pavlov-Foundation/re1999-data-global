module("modules.configs.excel2json.lua_activity154", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	puzzleTitle = 4,
	puzzleDesc = 5,
	puzzleId = 3,
	puzzleIcon = 6,
	answerId = 7,
	bonus = 8,
	activityId = 1,
	day = 2
}
local var_0_2 = {
	"activityId",
	"day"
}
local var_0_3 = {
	puzzleTitle = 1,
	puzzleDesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
