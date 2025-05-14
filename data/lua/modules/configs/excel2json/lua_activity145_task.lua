module("modules.configs.excel2json.lua_activity145_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	prepose = 11,
	name = 7,
	activity = 18,
	bonusMail = 17,
	maxFinishCount = 16,
	sort = 21,
	desc = 8,
	listenerParam = 14,
	needAccept = 9,
	params = 10,
	openLimit = 12,
	maxProgress = 15,
	activityId = 2,
	canRemove = 5,
	jumpId = 19,
	isOnline = 4,
	group = 3,
	listenerType = 13,
	minType = 6,
	id = 1,
	bonus = 20
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
