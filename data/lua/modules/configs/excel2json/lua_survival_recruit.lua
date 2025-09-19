module("modules.configs.excel2json.lua_survival_recruit", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	showNum = 2,
	randomNum = 5,
	refreshCost = 4,
	chooseNum = 6,
	id = 1,
	cost = 8,
	refreshTimes = 3,
	unlock = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
