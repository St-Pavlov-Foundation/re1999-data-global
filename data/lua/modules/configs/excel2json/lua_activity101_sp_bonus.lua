module("modules.configs.excel2json.lua_activity101_sp_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	canGetSignInDays = 6,
	taskDesc = 3,
	canGetDate = 5,
	id = 2,
	activityId = 1,
	bonus = 4
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	taskDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
