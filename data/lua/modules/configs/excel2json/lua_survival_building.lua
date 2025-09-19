module("modules.configs.excel2json.lua_survival_building", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	repairCost = 10,
	name = 4,
	ruins = 7,
	type = 3,
	effect = 11,
	unlockCondition = 5,
	sort = 12,
	destruction = 9,
	desc = 13,
	id = 1,
	icon = 8,
	lvUpCost = 6,
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
