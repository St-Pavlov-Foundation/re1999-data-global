module("modules.configs.excel2json.lua_activity101_springsign", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	goodDesc = 6,
	name = 3,
	simpleDesc = 4,
	detailDesc = 5,
	badDesc = 7,
	activityId = 1,
	day = 2
}
local var_0_2 = {
	"activityId",
	"day"
}
local var_0_3 = {
	goodDesc = 4,
	name = 1,
	simpleDesc = 2,
	detailDesc = 3,
	badDesc = 5
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
