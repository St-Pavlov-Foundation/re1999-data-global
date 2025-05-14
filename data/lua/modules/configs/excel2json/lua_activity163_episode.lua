module("modules.configs.excel2json.lua_activity163_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
local var_0_2 = {
	"activityId",
	"episodeId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
