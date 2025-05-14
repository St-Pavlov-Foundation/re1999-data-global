module("modules.configs.excel2json.lua_act139_explore_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	storyId = 4,
	unlockParam = 12,
	unlockDesc = 13,
	type = 3,
	unlockToastDesc = 14,
	title = 5,
	pos = 9,
	desc = 7,
	unlockLineNumbers = 15,
	unlockType = 11,
	areaPos = 8,
	titleEn = 6,
	id = 1,
	activityId = 2,
	elementIds = 10
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	unlockDesc = 3,
	title = 1,
	unlockToastDesc = 4,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
