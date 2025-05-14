module("modules.configs.excel2json.lua_activity114_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	listenerParam = 6,
	listenerType = 5,
	desc = 4,
	minTypeId = 3,
	bonus = 8,
	maxProgress = 7,
	activityId = 1,
	taskId = 2
}
local var_0_2 = {
	"activityId",
	"taskId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
