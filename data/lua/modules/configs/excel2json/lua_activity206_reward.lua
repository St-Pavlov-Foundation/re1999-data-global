module("modules.configs.excel2json.lua_activity206_reward", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	reward = 2,
	rewardId = 1,
	title = 4,
	pic = 5,
	des = 3
}
local var_0_2 = {
	"rewardId"
}
local var_0_3 = {
	title = 2,
	des = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
