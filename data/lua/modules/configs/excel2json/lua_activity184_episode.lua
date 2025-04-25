module("modules.configs.excel2json.lua_activity184_episode", package.seeall)

slot1 = {
	puzzleId = 3,
	preEpisodeId = 4,
	name = 5,
	storyId = 6,
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
