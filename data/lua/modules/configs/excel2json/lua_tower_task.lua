module("modules.configs.excel2json.lua_tower_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 13,
	name = 6,
	openLimit = 9,
	bonusMail = 8,
	listenerType = 10,
	maxProgress = 12,
	isOnline = 4,
	desc = 7,
	listenerParam = 11,
	minType = 5,
	isKeyReward = 15,
	id = 1,
	taskGroupId = 2,
	activityId = 3,
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
