module("modules.configs.excel2json.lua_activity152", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	presentName = 3,
	presentId = 2,
	roleNameEn = 8,
	presentIcon = 4,
	bonus = 10,
	acceptDate = 11,
	roleName = 7,
	roleIcon = 6,
	dialog = 9,
	activityId = 1,
	presentSign = 5
}
local var_0_2 = {
	"activityId",
	"presentId"
}
local var_0_3 = {
	roleName = 2,
	presentName = 1,
	dialog = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
