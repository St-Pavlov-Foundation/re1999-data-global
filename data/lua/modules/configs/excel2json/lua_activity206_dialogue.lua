module("modules.configs.excel2json.lua_activity206_dialogue", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	roleName = 4,
	roleIcon = 3,
	chaseId = 2,
	dialog = 6,
	roleNameEn = 5,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"chaseId"
}
local var_0_3 = {
	roleName = 1,
	dialog = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
