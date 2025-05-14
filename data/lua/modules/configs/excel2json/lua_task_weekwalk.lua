module("modules.configs.excel2json.lua_task_weekwalk", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sortId = 10,
	listenerType = 6,
	periods = 13,
	bonusMail = 12,
	maxFinishCount = 9,
	layerId = 5,
	desc = 4,
	listenerParam = 7,
	minType = 3,
	minTypeId = 2,
	id = 1,
	maxProgress = 8,
	bonus = 11
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
