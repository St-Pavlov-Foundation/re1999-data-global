module("modules.configs.excel2json.lua_actvity186_mini_game_reward", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	rewardId = 2,
	blessingdes = 6,
	type = 1,
	blessingtitle = 5,
	prob = 3,
	bonus = 4
}
local var_0_2 = {
	"type",
	"rewardId"
}
local var_0_3 = {
	blessingtitle = 1,
	blessingdes = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
