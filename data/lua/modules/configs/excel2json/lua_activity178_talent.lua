module("modules.configs.excel2json.lua_activity178_talent", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isBig = 7,
	name = 3,
	effect = 11,
	cost = 12,
	condition = 9,
	desc = 8,
	needLv = 10,
	point = 5,
	id = 2,
	icon = 6,
	activityId = 1,
	root = 4
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
