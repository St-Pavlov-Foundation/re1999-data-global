module("modules.configs.excel2json.lua_activity211_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 5,
	preEpisodeId = 3,
	preEpisodeBranchId = 4,
	storyBefore = 6,
	gameId = 7,
	storyClear = 8,
	activityId = 1,
	episodeId = 2
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
