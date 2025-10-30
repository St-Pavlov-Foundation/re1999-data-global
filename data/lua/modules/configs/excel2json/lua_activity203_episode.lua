module("modules.configs.excel2json.lua_activity203_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	storyBefore = 6,
	name = 5,
	preEpisodeBranchId = 4,
	type = 9,
	storyClear = 8,
	episodeId = 2,
	preEpisodeId = 3,
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
