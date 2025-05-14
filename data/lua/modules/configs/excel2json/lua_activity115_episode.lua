module("modules.configs.excel2json.lua_activity115_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	openDay = 11,
	winCondition = 7,
	conditionStr = 9,
	chapterId = 3,
	index = 4,
	preEpisode = 5,
	name = 6,
	extStarCondition = 8,
	tooth = 12,
	mapId = 10,
	unlockSkill = 13,
	maxRound = 14,
	id = 2,
	aniPos = 16,
	activityId = 1,
	trialTemplate = 15
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
