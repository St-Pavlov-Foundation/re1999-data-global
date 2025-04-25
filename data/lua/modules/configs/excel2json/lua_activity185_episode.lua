module("modules.configs.excel2json.lua_activity185_episode", package.seeall)

slot1 = {
	name = 4,
	preEpisodeId = 3,
	mapId = 6,
	storyId = 5,
	stage = 7,
	activityId = 1,
	episodeId = 2
}
slot2 = {
	"activityId",
	"episodeId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
