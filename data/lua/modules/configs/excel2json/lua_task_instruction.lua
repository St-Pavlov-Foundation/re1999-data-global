module("modules.configs.excel2json.lua_task_instruction", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	listenerParam = 6,
	minType = 3,
	listenerType = 5,
	name = 2,
	id = 1,
	maxProgress = 7,
	bonus = 8,
	desc = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	minType = 2,
	name = 1,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
