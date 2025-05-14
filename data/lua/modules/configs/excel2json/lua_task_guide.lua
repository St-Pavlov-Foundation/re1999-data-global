module("modules.configs.excel2json.lua_task_guide", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	maxProgress = 9,
	name = 5,
	isOnline = 2,
	bonusMail = 15,
	maxFinishCount = 10,
	part = 17,
	priority = 19,
	desc = 6,
	listenerParam = 8,
	chapter = 18,
	needAccept = 20,
	jumpId = 22,
	openLimit = 14,
	stage = 16,
	sortId = 12,
	activity = 11,
	prepose = 13,
	listenerType = 7,
	minType = 4,
	minTypeId = 3,
	id = 1,
	bonus = 21
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
