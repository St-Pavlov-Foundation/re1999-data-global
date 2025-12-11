module("modules.configs.excel2json.lua_survival_building", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	destruction = 10,
	name = 4,
	ruins = 8,
	type = 3,
	repairCost = 11,
	unlockCondition = 6,
	effect = 12,
	unName = 5,
	sort = 13,
	desc = 14,
	id = 1,
	icon = 9,
	lvUpCost = 7,
	level = 2
}
local var_0_2 = {
	"id",
	"level"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
