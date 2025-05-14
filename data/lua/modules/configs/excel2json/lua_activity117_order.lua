module("modules.configs.excel2json.lua_activity117_order", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	openDay = 4,
	name = 3,
	maxAcceptScore = 7,
	minDealScore = 6,
	jumpId = 12,
	maxDealScore = 8,
	listenerType = 9,
	listenerParam = 10,
	id = 2,
	maxProgress = 11,
	activityId = 1,
	order = 5
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
