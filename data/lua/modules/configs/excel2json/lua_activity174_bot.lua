module("modules.configs.excel2json.lua_activity174_bot", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	role2 = 8,
	collection3 = 13,
	count = 6,
	collection1 = 11,
	season = 3,
	role3 = 9,
	enhance = 15,
	collection4 = 14,
	role1 = 7,
	collection2 = 12,
	role4 = 10,
	id = 1,
	robotId = 4,
	activityId = 2,
	level = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
