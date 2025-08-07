module("modules.configs.excel2json.lua_activity193_dicegoal", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	goalname = 7,
	goaldesc = 8,
	lossrewards = 4,
	hardType = 2,
	mattername = 9,
	victoryrewards = 3,
	weight = 10,
	goalRange = 6,
	id = 1,
	bindingDice = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	mattername = 3,
	goaldesc = 2,
	goalname = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
