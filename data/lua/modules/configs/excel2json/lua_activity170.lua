module("modules.configs.excel2json.lua_activity170", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	summonTimes = 4,
	itemId = 2,
	constId = 6,
	heroExtraDesc = 7,
	initWeight = 3,
	activityId = 1,
	poolId = 5
}
local var_0_2 = {
	"activityId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
