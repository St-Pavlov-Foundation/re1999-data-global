module("modules.configs.excel2json.lua_activity109_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	openDay = 14,
	winCondition = 7,
	id = 2,
	chapterId = 5,
	conditionStr = 10,
	preEpisode = 3,
	mapId = 11,
	extStarCondition = 8,
	storyBefore = 12,
	maxRound = 9,
	storyClear = 13,
	name = 6,
	orderId = 4,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	conditionStr = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
