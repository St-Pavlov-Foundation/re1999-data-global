module("modules.configs.excel2json.lua_task_weekwalk_ver2", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	listenerType = 8,
	name = 6,
	isOnline = 3,
	bonusMail = 13,
	maxFinishCount = 11,
	layerId = 2,
	periods = 14,
	desc = 7,
	listenerParam = 9,
	minType = 5,
	minTypeId = 4,
	id = 1,
	maxProgress = 10,
	bonus = 12
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
