module("modules.configs.excel2json.lua_activity131_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	beforeStoryId = 8,
	name = 6,
	desc = 7,
	mapId = 5,
	afterStoryId = 9,
	elements = 10,
	scenes = 11,
	episodeId = 2,
	preEpisodeId = 4,
	episodetag = 3,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"episodeId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
