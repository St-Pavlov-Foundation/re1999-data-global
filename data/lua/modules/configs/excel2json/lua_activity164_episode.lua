module("modules.configs.excel2json.lua_activity164_episode", package.seeall)

slot1 = {
	activityId = 1,
	name = 3,
	preEpisode = 9,
	mapIds = 4,
	mainConditionStr = 5,
	storyClear = 8,
	storyRepeat = 10,
	mapName = 6,
	id = 2,
	storyBefore = 7
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	mainConditionStr = 2,
	name = 1,
	mapName = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
