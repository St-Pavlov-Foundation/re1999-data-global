module("modules.configs.excel2json.lua_activity178_marbles", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	detectTime = 9,
	name = 3,
	radius = 6,
	elasticity = 7,
	effectTime2 = 11,
	limit = 12,
	effectTime = 10,
	desc = 4,
	id = 2,
	icon = 5,
	activityId = 1,
	velocity = 8
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
