module("modules.configs.excel2json.lua_activity197", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	rummageConsume = 2,
	doubleTimes = 6,
	exploreNum = 5,
	activityConsume = 7,
	exploreConsume = 3,
	exploreItem = 4,
	activityId = 1,
	consumeBonus = 8
}
local var_0_2 = {
	"activityId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
