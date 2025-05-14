module("modules.configs.excel2json.lua_activity117_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	needScore = 4,
	bonus = 5,
	id = 2,
	activityId = 1,
	desc = 3
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
