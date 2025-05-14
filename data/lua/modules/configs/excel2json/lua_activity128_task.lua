module("modules.configs.excel2json.lua_activity128_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	achievementRes = 4,
	name = 8,
	stage = 3,
	bonusMail = 11,
	maxFinishCount = 17,
	activity = 18,
	desc = 9,
	listenerParam = 15,
	needAccept = 10,
	params = 12,
	openLimit = 13,
	maxProgress = 16,
	activityId = 2,
	jumpId = 19,
	isOnline = 5,
	totalTaskType = 6,
	listenerType = 14,
	minType = 7,
	id = 1,
	bonus = 20
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
