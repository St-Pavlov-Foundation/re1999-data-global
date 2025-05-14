module("modules.configs.excel2json.lua_challenge_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	groupId = 4,
	name = 7,
	bonusMail = 9,
	type = 3,
	maxFinishCount = 14,
	desc = 8,
	listenerParam = 12,
	openLimit = 10,
	maxProgress = 13,
	activityId = 2,
	jumpId = 15,
	isOnline = 5,
	listenerType = 11,
	minType = 6,
	id = 1,
	badgeNum = 17,
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
