module("modules.configs.excel2json.lua_task_explore", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	listenerType = 5,
	isOnline = 2,
	name = 3,
	display = 9,
	desc = 4,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	bonus = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
