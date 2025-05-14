module("modules.configs.excel2json.lua_act139_dispatch_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	desc = 9,
	time = 5,
	image = 10,
	title = 8,
	extraParam = 7,
	elementId = 11,
	shortType = 6,
	minCount = 3,
	maxCount = 4,
	activityId = 2
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
