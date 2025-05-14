module("modules.configs.excel2json.lua_activity119_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 8,
	isOnline = 6,
	bonusMail = 9,
	tabId = 4,
	openLimit = 10,
	listenerType = 11,
	bonus = 14,
	day = 3,
	listenerParam = 12,
	minType = 7,
	id = 1,
	maxProgress = 13,
	activityId = 2,
	sort = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	minType = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
