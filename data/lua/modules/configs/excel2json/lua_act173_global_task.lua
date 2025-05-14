module("modules.configs.excel2json.lua_act173_global_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 2,
	endValue = 3,
	activityId = 1,
	isVisible = 4
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
