module("modules.configs.excel2json.lua_activity205_dicegoal", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	winRewardId = 3,
	goaldesc = 8,
	hardType = 2,
	goalname = 7,
	iconRes = 9,
	weight = 10,
	goalRange = 6,
	failRewardId = 4,
	id = 1,
	bindingDice = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	goalname = 1,
	goaldesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
