module("modules.configs.excel2json.lua_activity109_episode", package.seeall)

slot1 = {
	openDay = 14,
	winCondition = 7,
	id = 2,
	chapterId = 5,
	conditionStr = 10,
	preEpisode = 3,
	mapId = 11,
	extStarCondition = 8,
	storyBefore = 12,
	maxRound = 9,
	storyClear = 13,
	name = 6,
	orderId = 4,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	conditionStr = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
