module("modules.configs.excel2json.lua_activity113_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isOnline = 3,
	name = 5,
	isKeyReward = 20,
	bonusMail = 8,
	maxFinishCount = 15,
	desc = 6,
	listenerParam = 13,
	needAccept = 7,
	params = 9,
	openLimit = 11,
	maxProgress = 14,
	activityId = 2,
	page = 19,
	jumpId = 17,
	activity = 16,
	prepose = 10,
	listenerType = 12,
	minType = 4,
	id = 1,
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
