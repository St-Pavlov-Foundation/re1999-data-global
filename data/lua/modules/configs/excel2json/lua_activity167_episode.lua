module("modules.configs.excel2json.lua_activity167_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 4,
	winCondition = 7,
	id = 2,
	subConditionStr = 9,
	exStarCondition = 10,
	subCondition = 8,
	conditionStr = 11,
	storyBefore = 12,
	storyClear = 13,
	mapId = 6,
	preEpisode = 14,
	cubeList = 15,
	episodeType = 3,
	activityId = 1,
	nameEn = 5
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	conditionStr = 3,
	name = 1,
	subConditionStr = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
