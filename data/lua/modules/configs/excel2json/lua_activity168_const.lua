module("modules.configs.excel2json.lua_activity168_const", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activityId = 1,
	value1 = 3,
	mlValue = 5,
	id = 2,
	value2 = 4
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	value2 = 1,
	mlValue = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
