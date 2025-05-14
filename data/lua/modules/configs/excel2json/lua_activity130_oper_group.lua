module("modules.configs.excel2json.lua_activity130_oper_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	operGroupId = 2,
	descImg = 5,
	name = 9,
	operDesc = 4,
	operType = 3,
	audioId = 8,
	shapegetImg = 7,
	shapeImg = 6,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"operGroupId",
	"operType"
}
local var_0_3 = {
	name = 2,
	operDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
