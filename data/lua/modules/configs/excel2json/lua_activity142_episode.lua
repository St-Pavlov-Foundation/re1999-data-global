module("modules.configs.excel2json.lua_activity142_episode", package.seeall)

slot1 = {
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
