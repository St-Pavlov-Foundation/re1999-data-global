module("modules.configs.excel2json.lua_activity192_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	storyBefore = 7,
	name = 6,
	preEpisodeBranchId = 4,
	isExtra = 9,
	storyClear = 8,
	episodeId = 2,
	preEpisodeId = 3,
	activityId = 1,
	gameId = 5
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
