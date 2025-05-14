module("modules.configs.excel2json.lua_investigate_reward", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	listenerParam = 4,
	minType = 2,
	listenerType = 3,
	desc = 6,
	bonus = 7,
	maxProgress = 5,
	jumpId = 8,
	taskId = 1
}
local var_0_2 = {
	"taskId"
}
local var_0_3 = {
	desc = 2,
	minType = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
