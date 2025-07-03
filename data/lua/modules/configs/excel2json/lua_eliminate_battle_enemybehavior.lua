module("modules.configs.excel2json.lua_eliminate_battle_enemybehavior", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	prob3 = 9,
	list3 = 8,
	prob2 = 7,
	prob1 = 5,
	list1 = 4,
	round = 3,
	behavior = 2,
	list2 = 6,
	id = 1
}
local var_0_2 = {
	"id",
	"behavior"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
