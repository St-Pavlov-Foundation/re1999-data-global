module("modules.configs.excel2json.lua_task_room", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bonusIcon = 20,
	name = 4,
	bonusMail = 9,
	maxFinishCount = 16,
	desc = 5,
	listenerParam = 14,
	needAccept = 8,
	params = 10,
	openLimit = 12,
	maxProgress = 15,
	order = 7,
	tips = 6,
	isOnline = 2,
	prepose = 11,
	listenerType = 13,
	onceBonus = 19,
	minType = 3,
	id = 1,
	needReset = 18,
	bonus = 17
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	tips = 4,
	minType = 1,
	name = 2,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
