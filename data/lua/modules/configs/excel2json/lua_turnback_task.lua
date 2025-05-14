module("modules.configs.excel2json.lua_turnback_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sortId = 11,
	name = 6,
	unlockDay = 17,
	type = 18,
	isOnlineTimeTask = 19,
	acceptNeedOnlineSeconds = 20,
	desc = 7,
	listenerParam = 9,
	params = 14,
	openLimit = 13,
	maxProgress = 10,
	jumpId = 15,
	isOnline = 3,
	prepose = 12,
	loopType = 4,
	listenerType = 8,
	minType = 5,
	id = 1,
	turnbackId = 2,
	bonus = 16
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
