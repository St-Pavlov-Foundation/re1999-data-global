module("modules.configs.excel2json.lua_activity161_graffiti", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	dialogGroupId = 7,
	subElementIds = 6,
	activityId = 1,
	finishRate = 9,
	mainElementCd = 5,
	picture = 8,
	finishTitle = 12,
	finishDesc = 13,
	elementId = 2,
	preMainElementIds = 4,
	finishTitleEn = 14,
	brushSize = 10,
	mainElementId = 3,
	sort = 11
}
local var_0_2 = {
	"activityId",
	"elementId"
}
local var_0_3 = {
	finishDesc = 2,
	finishTitle = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
