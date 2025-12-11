module("modules.configs.excel2json.lua_activity191_bot", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	enhance = 15,
	role3 = 5,
	collection3 = 13,
	prepareRole3 = 9,
	prepareRole1 = 7,
	rank = 17,
	powerInitial = 16,
	role1 = 3,
	prepareRole2 = 8,
	activityId = 2,
	role2 = 4,
	prepareRole4 = 10,
	collection1 = 11,
	collection4 = 14,
	collection2 = 12,
	role4 = 6,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
