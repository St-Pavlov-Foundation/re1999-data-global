module("modules.configs.excel2json.lua_task_season", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sortId = 12,
	isOnline = 5,
	listenerType = 8,
	activity104EquipBonus = 14,
	maxFinishCount = 11,
	jumpId = 15,
	desc = 7,
	listenerParam = 9,
	minType = 4,
	seasonId = 2,
	minTypeId = 3,
	id = 1,
	maxProgress = 10,
	bgType = 6,
	bonus = 13
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
