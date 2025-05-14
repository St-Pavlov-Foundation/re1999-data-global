module("modules.configs.excel2json.lua_activity_show", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 6,
	taskDesc = 4,
	centerId = 7,
	actDesc = 3,
	id = 2,
	activityId = 1,
	showBonus = 5
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	taskDesc = 2,
	actDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
