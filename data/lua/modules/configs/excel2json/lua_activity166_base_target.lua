module("modules.configs.excel2json.lua_activity166_base_target", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	score = 6,
	targetParam = 5,
	targetType = 4,
	targetId = 3,
	baseId = 2,
	targetDesc = 7,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"baseId",
	"targetId"
}
local var_0_3 = {
	targetDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
