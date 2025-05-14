module("modules.configs.excel2json.lua_activity130_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	lvscene = 11,
	name = 6,
	desc = 7,
	mapId = 5,
	afterStoryId = 9,
	elements = 10,
	beforeStoryId = 8,
	episodeId = 2,
	scenes = 12,
	preEpisodeId = 4,
	winCondition = 13,
	conditionStr = 14,
	episodetag = 3,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"episodeId"
}
local var_0_3 = {
	conditionStr = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
