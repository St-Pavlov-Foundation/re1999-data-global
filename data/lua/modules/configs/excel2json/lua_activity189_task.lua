module("modules.configs.excel2json.lua_activity189_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	openLimitActId = 14,
	name = 6,
	openLimit = 9,
	bonusMail = 8,
	desc = 7,
	listenerParam = 11,
	clientlistenerParam = 12,
	tag = 13,
	maxProgress = 16,
	activityId = 2,
	jumpId = 17,
	isOnline = 3,
	loopType = 4,
	listenerType = 10,
	minType = 5,
	id = 1,
	sorting = 15,
	bonus = 18
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
