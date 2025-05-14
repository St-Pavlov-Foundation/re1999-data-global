module("modules.configs.excel2json.lua_activity139_hero_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	ringIds = 4,
	heroId = 3,
	id = 1,
	finalReward = 5,
	activityId = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	ringIds = 1,
	finalReward = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
