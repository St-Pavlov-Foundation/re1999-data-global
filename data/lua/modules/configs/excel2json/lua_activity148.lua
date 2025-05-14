module("modules.configs.excel2json.lua_activity148", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	skillSmallIcon = 8,
	skillId = 6,
	cost = 5,
	type = 3,
	skillAttrDesc = 9,
	attrs = 7,
	id = 1,
	activityId = 2,
	level = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	skillAttrDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
