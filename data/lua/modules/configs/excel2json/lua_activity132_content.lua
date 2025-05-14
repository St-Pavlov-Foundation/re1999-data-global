module("modules.configs.excel2json.lua_activity132_content", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	content = 3,
	activityId = 1,
	contentId = 2,
	unlockDesc = 5,
	condition = 4
}
local var_0_2 = {
	"activityId",
	"contentId"
}
local var_0_3 = {
	content = 1,
	unlockDesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
