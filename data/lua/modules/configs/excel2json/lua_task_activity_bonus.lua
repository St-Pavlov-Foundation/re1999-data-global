module("modules.configs.excel2json.lua_task_activity_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	hideInVerifing = 6,
	bonus = 5,
	desc = 3,
	type = 1,
	id = 2,
	needActivity = 4
}
local var_0_2 = {
	"type",
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
