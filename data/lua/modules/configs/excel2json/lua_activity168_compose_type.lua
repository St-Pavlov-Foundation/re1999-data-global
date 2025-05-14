module("modules.configs.excel2json.lua_activity168_compose_type", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 3,
	composeType = 2,
	activityId = 1,
	costItems = 4
}
local var_0_2 = {
	"activityId",
	"composeType"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
