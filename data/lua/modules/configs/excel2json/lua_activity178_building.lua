module("modules.configs.excel2json.lua_activity178_building", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 12,
	effect = 7,
	desc2 = 11,
	type = 4,
	name = 5,
	uiOffset = 13,
	condition = 6,
	desc = 10,
	destory = 14,
	res = 8,
	limit = 15,
	size = 16,
	id = 2,
	icon = 9,
	activityId = 1,
	level = 3
}
local var_0_2 = {
	"activityId",
	"id",
	"level"
}
local var_0_3 = {
	desc2 = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
