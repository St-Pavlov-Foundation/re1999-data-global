module("modules.configs.excel2json.lua_assassin_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 13,
	name = 5,
	isOnline = 3,
	bonusMail = 7,
	maxFinishCount = 12,
	listenerType = 9,
	id = 1,
	desc = 6,
	listenerParam = 10,
	minType = 4,
	openLimit = 8,
	maxProgress = 11,
	activityId = 2,
	bonus = 14
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
