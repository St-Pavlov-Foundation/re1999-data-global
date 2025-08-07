module("modules.configs.excel2json.lua_actvity204_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	missionorder = 17,
	name = 7,
	realPrepose = 18,
	bonusMail = 9,
	durationHour = 19,
	durationLimitActivityId = 21,
	secretornot = 20,
	desc = 8,
	listenerParam = 11,
	openLimit = 14,
	maxProgress = 12,
	activityId = 2,
	jumpId = 15,
	isOnline = 3,
	prepose = 13,
	loopType = 4,
	listenerType = 10,
	minType = 6,
	id = 1,
	acceptStage = 5,
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
