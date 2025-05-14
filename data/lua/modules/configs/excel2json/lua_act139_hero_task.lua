module("modules.configs.excel2json.lua_act139_hero_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	reward = 8,
	heroId = 3,
	preEpisodeId = 9,
	title = 4,
	toastId = 10,
	desc = 7,
	heroIcon = 6,
	heroTabIcon = 5,
	id = 1,
	activityId = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
