module("modules.configs.excel2json.lua_activity164_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activityId = 1,
	name = 3,
	preEpisode = 9,
	mapIds = 4,
	mainConditionStr = 5,
	storyClear = 8,
	storyRepeat = 10,
	mapName = 6,
	id = 2,
	storyBefore = 7
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	mainConditionStr = 2,
	name = 1,
	mapName = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
