module("modules.configs.excel2json.lua_activity173_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sortId = 9,
	isOnline = 2,
	name = 4,
	bonusMail = 12,
	prepose = 10,
	openLimit = 11,
	listenerType = 6,
	desc = 5,
	listenerParam = 7,
	minType = 3,
	jumpId = 15,
	params = 13,
	id = 1,
	maxProgress = 8,
	activityId = 16,
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
