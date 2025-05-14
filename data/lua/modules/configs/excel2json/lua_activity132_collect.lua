module("modules.configs.excel2json.lua_activity132_collect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	nameEn = 6,
	name = 3,
	collectId = 2,
	bg = 4,
	activityId = 1,
	clues = 5
}
local var_0_2 = {
	"activityId",
	"collectId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
