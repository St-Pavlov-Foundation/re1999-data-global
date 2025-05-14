module("modules.configs.excel2json.lua_activity184_puzzle_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	titile = 10,
	titleTxt = 7,
	date = 6,
	txt = 9,
	target = 5,
	illustrationCount = 8,
	staticShape = 4,
	id = 2,
	size = 3,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	txt = 2,
	titleTxt = 1,
	titile = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
