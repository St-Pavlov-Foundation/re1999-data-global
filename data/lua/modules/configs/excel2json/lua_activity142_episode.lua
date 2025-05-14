module("modules.configs.excel2json.lua_activity142_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activityId = 1,
	name = 6,
	id = 2,
	chapterId = 5,
	conditionStr = 12,
	preEpisode = 3,
	normalSprite = 7,
	storyClear = 17,
	maxRound = 13,
	storyBefore = 16,
	openDay = 18,
	storyRepeat = 19,
	mapIds = 14,
	mainConditionStr = 10,
	pickUpObjIds = 15,
	extStarCondition = 11,
	mainConfition = 9,
	orderId = 4,
	lockSprite = 8
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
