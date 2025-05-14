module("modules.configs.excel2json.lua_activity144_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 10,
	name = 6,
	isOnline = 3,
	desc = 12,
	showType = 13,
	episodeId = 14,
	loopType = 4,
	listenerType = 7,
	listenerParam = 8,
	minType = 5,
	id = 1,
	maxProgress = 9,
	activityId = 2,
	bonus = 11
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 3,
	minType = 2,
	loopType = 1,
	desc = 4
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
