module("modules.configs.excel2json.lua_activity214_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bonusScore = 17,
	name = 7,
	jumpId = 18,
	bonusMail = 15,
	endTime = 20,
	desc = 8,
	listenerParam = 10,
	bpId = 3,
	params = 16,
	openLimit = 14,
	maxProgress = 11,
	activityId = 4,
	sortId = 12,
	isOnline = 2,
	prepose = 13,
	loopType = 5,
	listenerType = 9,
	minType = 6,
	id = 1,
	startTime = 19
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
