module("modules.configs.excel2json.lua_activity114_feature", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	verifyNum = 5,
	inheritable = 9,
	attributeNum = 6,
	courseEfficiency = 7,
	desc = 4,
	restEfficiency = 8,
	id = 2,
	features = 3,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	desc = 2,
	features = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
