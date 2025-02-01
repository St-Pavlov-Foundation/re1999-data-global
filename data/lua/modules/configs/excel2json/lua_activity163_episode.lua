module("modules.configs.excel2json.lua_activity163_episode", package.seeall)

slot1 = {
	beforeStoryId = 5,
	name = 4,
	maxError = 10,
	promptsNum = 11,
	afterStoryId = 6,
	playerPieces = 12,
	opponentPieces = 13,
	episodeId = 2,
	evidenceId = 7,
	preEpisodeId = 3,
	failedId = 14,
	initialDialog = 8,
	activityId = 1,
	initialCluesIds = 9
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
