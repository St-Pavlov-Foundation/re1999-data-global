module("modules.configs.excel2json.lua_activity129_reward", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	initWeight = 3,
	changeWeight = 4,
	activityId = 1,
	poolId = 2
}
local var_0_2 = {
	"activityId",
	"poolId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
