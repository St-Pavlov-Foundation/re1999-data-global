module("modules.configs.excel2json.lua_activity167_episode", package.seeall)

slot1 = {
	name = 4,
	winCondition = 7,
	id = 2,
	subConditionStr = 9,
	exStarCondition = 10,
	subCondition = 8,
	conditionStr = 11,
	storyBefore = 12,
	storyClear = 13,
	mapId = 6,
	preEpisode = 14,
	cubeList = 15,
	episodeType = 3,
	activityId = 1,
	nameEn = 5
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	conditionStr = 3,
	name = 1,
	subConditionStr = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
