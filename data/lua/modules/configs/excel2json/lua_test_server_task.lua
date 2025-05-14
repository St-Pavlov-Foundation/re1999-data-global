module("modules.configs.excel2json.lua_test_server_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sortId = 10,
	name = 5,
	endTime = 17,
	bonusMail = 13,
	bonus = 18,
	desc = 6,
	listenerParam = 8,
	params = 14,
	openLimit = 12,
	maxProgress = 9,
	activityId = 19,
	jumpId = 15,
	isOnline = 2,
	prepose = 11,
	loopType = 3,
	listenerType = 7,
	minType = 4,
	id = 1,
	startTime = 16
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
