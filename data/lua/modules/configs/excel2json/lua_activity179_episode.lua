module("modules.configs.excel2json.lua_activity179_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name_En = 7,
	name = 6,
	orderId = 5,
	id = 2,
	storyAfter = 10,
	preEpisode = 3,
	beatId = 8,
	storyBefore = 9,
	episodeType = 4,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
