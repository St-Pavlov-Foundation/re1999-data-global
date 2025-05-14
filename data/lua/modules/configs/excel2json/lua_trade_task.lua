module("modules.configs.excel2json.lua_trade_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sortId = 6,
	isOnline = 14,
	extraBonus = 12,
	speaker = 9,
	logtext = 10,
	icon = 11,
	listenerType = 3,
	desc = 2,
	listenerParam = 4,
	minType = 15,
	maxProgress = 5,
	jumpId = 13,
	id = 1,
	addRoomLog = 8,
	tradeLevel = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	minType = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
