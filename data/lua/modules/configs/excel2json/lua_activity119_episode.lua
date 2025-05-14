module("modules.configs.excel2json.lua_activity119_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	openDay = 5,
	name = 3,
	tabId = 4,
	id = 2,
	icon = 6,
	activityId = 1,
	des = 7
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	des = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
