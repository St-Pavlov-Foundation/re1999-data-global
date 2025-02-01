module("modules.configs.excel2json.lua_activity122_episode", package.seeall)

slot1 = {
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
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	conditionStr = 2,
	name = 1,
	extConditionStr = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
