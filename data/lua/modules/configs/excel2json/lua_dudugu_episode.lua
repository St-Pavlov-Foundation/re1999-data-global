module("modules.configs.excel2json.lua_dudugu_episode", package.seeall)

slot1 = {
	beforeStoryId = 7,
	name = 5,
	levelId = 2,
	episodeId = 9,
	afterStoryId = 8,
	desc = 6,
	preEpisodeId = 4,
	episodetag = 3,
	activityId = 1
}
slot2 = {
	"activityId",
	"levelId"
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
