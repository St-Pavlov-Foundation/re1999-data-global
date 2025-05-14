module("modules.configs.excel2json.lua_activity122_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	openDay = 15,
	name = 6,
	conditionStr = 9,
	chapterId = 5,
	extStarCondition = 10,
	preEpisode = 3,
	extConditionStr = 11,
	starCondition = 8,
	mapIds = 12,
	storyBefore = 13,
	hp = 7,
	storyClear = 14,
	orderId = 4,
	id = 2,
	activityId = 1,
	storyRepeat = 16
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	conditionStr = 2,
	name = 1,
	extConditionStr = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
