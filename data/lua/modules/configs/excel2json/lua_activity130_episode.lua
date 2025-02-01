module("modules.configs.excel2json.lua_activity130_episode", package.seeall)

slot1 = {
	lvscene = 11,
	name = 6,
	desc = 7,
	mapId = 5,
	afterStoryId = 9,
	elements = 10,
	beforeStoryId = 8,
	episodeId = 2,
	scenes = 12,
	preEpisodeId = 4,
	winCondition = 13,
	conditionStr = 14,
	episodetag = 3,
	activityId = 1
}
slot2 = {
	"activityId",
	"episodeId"
}
slot3 = {
	conditionStr = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
