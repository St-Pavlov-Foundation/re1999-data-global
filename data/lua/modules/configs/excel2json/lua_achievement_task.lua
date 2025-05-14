module("modules.configs.excel2json.lua_achievement_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sortId = 8,
	listenerType = 5,
	achievementId = 2,
	extraDesc = 4,
	icon = 10,
	desc = 3,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	level = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	extraDesc = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
