module("modules.configs.excel2json.lua_activity191_collection", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	label = 8,
	tag2 = 7,
	replaceDesc = 10,
	desc = 9,
	tag = 6,
	title = 5,
	rare = 3,
	unique = 4,
	weight = 12,
	id = 1,
	icon = 11,
	activityId = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	label = 2,
	title = 1,
	replaceDesc = 4,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
