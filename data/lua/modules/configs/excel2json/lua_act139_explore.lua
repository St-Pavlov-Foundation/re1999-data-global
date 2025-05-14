module("modules.configs.excel2json.lua_act139_explore", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	desc = 8,
	time = 5,
	minCount = 3,
	maxCount = 4,
	title = 7,
	activityId = 2,
	extraParam = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
