module("modules.configs.excel2json.lua_push_box_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 5,
	isOnline = 3,
	listenerType = 6,
	bonus = 10,
	taskId = 2,
	listenerParam = 7,
	minTypeId = 4,
	maxProgress = 8,
	activityId = 1,
	sort = 9
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
