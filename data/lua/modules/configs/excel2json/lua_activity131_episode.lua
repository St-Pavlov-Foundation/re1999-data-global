module("modules.configs.excel2json.lua_activity131_episode", package.seeall)

slot1 = {
	beforeStoryId = 8,
	name = 6,
	desc = 7,
	mapId = 5,
	afterStoryId = 9,
	elements = 10,
	scenes = 11,
	episodeId = 2,
	preEpisodeId = 4,
	episodetag = 3,
	activityId = 1
}
slot2 = {
	"activityId",
	"episodeId"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
