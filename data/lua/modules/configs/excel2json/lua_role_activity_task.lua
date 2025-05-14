module("modules.configs.excel2json.lua_role_activity_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	taskDesc = 5,
	name = 4,
	jumpid = 10,
	listenerType = 6,
	listenerParam = 7,
	minType = 3,
	id = 2,
	maxProgress = 8,
	activityId = 1,
	bonus = 9
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	name = 2,
	minType = 1,
	taskDesc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
