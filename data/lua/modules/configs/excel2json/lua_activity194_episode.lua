module("modules.configs.excel2json.lua_activity194_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	beforeStory = 5,
	preEpisodeId = 3,
	name = 4,
	afterStory = 7,
	gameId = 6,
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
