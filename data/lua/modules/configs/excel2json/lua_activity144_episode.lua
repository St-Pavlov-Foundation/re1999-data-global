module("modules.configs.excel2json.lua_activity144_episode", package.seeall)

slot1 = {
	bgPath = 7,
	name = 4,
	picture = 6,
	nameen = 10,
	taskId = 8,
	preEpisode = 3,
	unlockDesc = 9,
	episodeId = 2,
	desc = 5,
	storyBefore = 11,
	storyClear = 12,
	showTargets = 13,
	bonus = 15,
	activityId = 1,
	showBonus = 14
}
slot2 = {
	"activityId",
	"episodeId"
}
slot3 = {
	unlockDesc = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
