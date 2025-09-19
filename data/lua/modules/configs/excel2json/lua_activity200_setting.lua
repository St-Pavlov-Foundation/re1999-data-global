module("modules.configs.excel2json.lua_activity200_setting", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	detial = 3,
	size = 2,
	activityId = 1,
	failText = 4
}
local var_0_2 = {
	"activityId"
}
local var_0_3 = {
	failText = 2,
	detial = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
