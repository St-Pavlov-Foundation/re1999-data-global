module("modules.configs.excel2json.lua_hero_story_dispatch", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	scoreReward = 9,
	name = 4,
	count = 8,
	type = 2,
	time = 10,
	effect = 12,
	effectDesc = 13,
	desc = 5,
	unlockEpisodeId = 14,
	talkIds = 15,
	heroStoryId = 3,
	consume = 7,
	id = 1,
	effectCondition = 11,
	completeDesc = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	effectDesc = 4,
	name = 1,
	completeDesc = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
