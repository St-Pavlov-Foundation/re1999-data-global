module("modules.configs.excel2json.lua_activity157_repair_map", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	componentId = 2,
	height = 5,
	titleTip = 3,
	activityId = 1,
	tilebase = 6,
	objects = 7,
	width = 4,
	desc = 8
}
local var_0_2 = {
	"activityId",
	"componentId"
}
local var_0_3 = {
	titleTip = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
