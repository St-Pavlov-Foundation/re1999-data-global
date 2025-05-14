module("modules.configs.excel2json.lua_reward", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	reward_id = 1,
	rewardGroup1 = 4,
	dailyDrop = 2,
	rewardGroup2 = 5,
	rewardGroup3 = 6,
	rewardGroup4 = 7,
	dailyGainWarning = 3,
	rewardGroup5 = 8,
	rewardGroup6 = 9
}
local var_0_2 = {
	"reward_id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
