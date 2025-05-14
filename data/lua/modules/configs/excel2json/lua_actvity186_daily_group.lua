module("modules.configs.excel2json.lua_actvity186_daily_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	acceptInterval = 5,
	bonus = 6,
	rewardId = 2,
	groupId = 1,
	acceptTime = 3,
	isLoopBonus = 4
}
local var_0_2 = {
	"groupId",
	"rewardId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
