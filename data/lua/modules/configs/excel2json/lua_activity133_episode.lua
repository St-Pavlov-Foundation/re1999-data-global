module("modules.configs.excel2json.lua_activity133_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 8,
	listenerType = 5,
	orActivity = 9,
	prop = 4,
	desc = 3,
	listenerParam = 6,
	loopDay = 10,
	id = 2,
	maxProgress = 7,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	maxProgress = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
