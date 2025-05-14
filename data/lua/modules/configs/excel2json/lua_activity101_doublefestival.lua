module("modules.configs.excel2json.lua_activity101_doublefestival", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	blessTitle = 5,
	blessContent = 7,
	blessTitleEn = 6,
	btnDesc = 4,
	blessDesc = 8,
	blessContentType = 10,
	day = 2,
	bgSpriteName = 3,
	activityId = 1,
	blessSpriteName = 9
}
local var_0_2 = {
	"activityId",
	"day"
}
local var_0_3 = {
	btnDesc = 2,
	bgSpriteName = 1,
	blessContent = 5,
	blessDesc = 6,
	blessTitle = 3,
	blessContentType = 8,
	blessTitleEn = 4,
	blessSpriteName = 7
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
