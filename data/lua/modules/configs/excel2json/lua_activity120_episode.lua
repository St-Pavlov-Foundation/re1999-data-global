module("modules.configs.excel2json.lua_activity120_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	orderId = 4,
	name = 6,
	chapterId = 5,
	inactPaths = 16,
	conditionStr = 11,
	preEpisode = 3,
	storyBefore = 13,
	maxRound = 10,
	activityId = 1,
	openDay = 15,
	storyRepeat = 17,
	mapIds = 12,
	mainConditionStr = 8,
	storyClear = 14,
	extStarCondition = 9,
	mainConfition = 7,
	id = 2
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	mainConditionStr = 2,
	name = 1,
	conditionStr = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
