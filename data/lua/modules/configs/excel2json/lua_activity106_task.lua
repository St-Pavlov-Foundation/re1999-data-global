module("modules.configs.excel2json.lua_activity106_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	orderid = 17,
	name = 5,
	bonusMail = 8,
	maxFinishCount = 14,
	desc = 6,
	listenerParam = 12,
	needAccept = 7,
	params = 9,
	openLimit = 10,
	maxProgress = 13,
	activityId = 2,
	openDay = 16,
	isOnline = 3,
	listenerType = 11,
	minType = 4,
	id = 1,
	bonus = 15
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
