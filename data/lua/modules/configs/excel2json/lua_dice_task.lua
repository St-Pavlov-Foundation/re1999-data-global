module("modules.configs.excel2json.lua_dice_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 11,
	isOnline = 2,
	id = 1,
	bonusMail = 6,
	name = 4,
	listenerType = 8,
	desc = 5,
	listenerParam = 9,
	minType = 3,
	openLimit = 7,
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
