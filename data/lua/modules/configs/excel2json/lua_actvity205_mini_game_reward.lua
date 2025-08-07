module("modules.configs.excel2json.lua_actvity205_mini_game_reward", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isWin = 4,
	rewardId = 2,
	rewardDesc = 5,
	type = 1,
	bonus = 3
}
local var_0_2 = {
	"type",
	"rewardId"
}
local var_0_3 = {
	rewardDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
