module("modules.configs.excel2json.lua_activity130_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 10,
	name = 5,
	episodeId = 9,
	isOnline = 3,
	loopType = 4,
	listenerType = 6,
	listenerParam = 7,
	id = 1,
	maxProgress = 8,
	activityId = 2,
	bonus = 11
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	loopType = 1,
	name = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
