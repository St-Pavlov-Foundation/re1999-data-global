module("modules.configs.excel2json.lua_activity190_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	eliminateLevelId = 9,
	name = 5,
	preEpisodeBranchId = 4,
	type = 10,
	storyBefore = 6,
	storyClear = 8,
	maxRound = 12,
	episodeId = 2,
	masterId = 13,
	preEpisodeId = 3,
	enemyId = 11,
	activityId = 1,
	gameId = 7
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
