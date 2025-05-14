module("modules.configs.excel2json.lua_bp_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	listenerType = 8,
	name = 6,
	bonusScoreTimes = 22,
	bonusMail = 14,
	endTime = 19,
	turnbackTask = 20,
	jumpId = 17,
	desc = 7,
	listenerParam = 9,
	bpId = 3,
	params = 15,
	openLimit = 13,
	maxProgress = 10,
	sortId = 11,
	isOnline = 2,
	prepose = 12,
	loopType = 4,
	bonusScore = 16,
	minType = 5,
	id = 1,
	newbieTask = 21,
	startTime = 18
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
