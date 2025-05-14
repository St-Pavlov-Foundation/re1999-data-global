module("modules.configs.excel2json.lua_activity144_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bgPath = 7,
	name = 4,
	picture = 6,
	nameen = 10,
	taskId = 8,
	preEpisode = 3,
	unlockDesc = 9,
	episodeId = 2,
	desc = 5,
	storyBefore = 11,
	storyClear = 12,
	showTargets = 13,
	bonus = 15,
	activityId = 1,
	showBonus = 14
}
local var_0_2 = {
	"activityId",
	"episodeId"
}
local var_0_3 = {
	unlockDesc = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
