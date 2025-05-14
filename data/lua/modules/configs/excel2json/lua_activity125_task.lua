module("modules.configs.excel2json.lua_activity125_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 15,
	name = 5,
	isOnline = 3,
	bonusMail = 7,
	listenerType = 9,
	tag = 12,
	maxProgress = 14,
	desc = 6,
	listenerParam = 10,
	minType = 4,
	id = 1,
	clientlistenerParam = 11,
	openLimit = 8,
	sorting = 13,
	activityId = 2,
	bonus = 16
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 2,
	minType = 1,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
