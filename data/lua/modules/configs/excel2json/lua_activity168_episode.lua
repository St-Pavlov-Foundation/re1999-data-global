module("modules.configs.excel2json.lua_activity168_episode", package.seeall)

slot1 = {
	activityId = 1,
	name = 6,
	orderId = 5,
	id = 2,
	preEpisode = 3,
	episodeId = 9,
	mapId = 7,
	episodeType = 4,
	storyBefore = 8
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
