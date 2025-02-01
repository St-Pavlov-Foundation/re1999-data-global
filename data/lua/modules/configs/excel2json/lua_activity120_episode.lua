module("modules.configs.excel2json.lua_activity120_episode", package.seeall)

slot1 = {
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
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	mainConditionStr = 2,
	name = 1,
	conditionStr = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
