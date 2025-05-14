module("modules.configs.excel2json.lua_adventure_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	taskType = 5,
	name = 3,
	openLimit = 10,
	listenerType = 11,
	prepose = 9,
	banner = 7,
	isForever = 15,
	desc = 4,
	listenerParam = 12,
	mapId = 2,
	task_desc = 6,
	params = 8,
	id = 1,
	maxProgress = 13,
	bonus = 14
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	task_desc = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
