module("modules.configs.excel2json.lua_task_hide_achievement", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 4,
	isOnline = 2,
	openLimit = 9,
	bonusMail = 7,
	maxFinishCount = 13,
	listenerType = 10,
	desc = 5,
	listenerParam = 11,
	minType = 3,
	needAccept = 6,
	params = 8,
	id = 1,
	maxProgress = 12,
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
