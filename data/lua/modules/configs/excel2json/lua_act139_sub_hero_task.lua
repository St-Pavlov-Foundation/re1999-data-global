module("modules.configs.excel2json.lua_act139_sub_hero_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	reward = 8,
	descSuffix = 7,
	desc = 6,
	storyId = 3,
	title = 4,
	image = 5,
	unlockParam = 11,
	taskId = 2,
	lockDesc = 12,
	unlockType = 10,
	id = 1,
	elementIds = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	descSuffix = 3,
	title = 1,
	lockDesc = 4,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
