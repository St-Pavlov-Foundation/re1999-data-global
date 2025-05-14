module("modules.configs.excel2json.lua_dudugu_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	beforeStoryId = 7,
	name = 5,
	levelId = 2,
	episodeId = 9,
	afterStoryId = 8,
	desc = 6,
	preEpisodeId = 4,
	episodetag = 3,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"levelId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
