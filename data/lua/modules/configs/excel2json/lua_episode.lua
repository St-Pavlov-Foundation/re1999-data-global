module("modules.configs.excel2json.lua_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bgmevent = 30,
	name = 4,
	retroFirstBonus = 41,
	dayChangeBonus = 24,
	beforeStory = 8,
	preEpisode = 16,
	pic = 14,
	battleDesc = 7,
	afterStory = 10,
	type = 3,
	saveDayNum = 38,
	navigationpic = 31,
	battleId = 23,
	icon = 15,
	freeBonus = 35,
	canUseRecord = 33,
	desc = 6,
	permanentRewardDisplayList = 50,
	displayMark = 39,
	autoSkipStory = 11,
	lockTime = 40,
	chapterId = 2,
	retroAdvancedBonus = 43,
	freeDisplayList = 36,
	advancedBonus = 27,
	preEpisodeId = 17,
	year = 32,
	permanentAdvancedBonus = 49,
	id = 1,
	retroBonus = 42,
	retroRewardList = 45,
	bonus = 26,
	dayNum = 37,
	chainEpisode = 46,
	retroRewardDisplayList = 44,
	rewardDisplayList = 28,
	rewardList = 29,
	firstBonus = 25,
	reward = 52,
	story = 9,
	elementList = 19,
	firstBattleId = 22,
	failCost = 21,
	retroReward = 53,
	name_En = 5,
	permanentBonus = 48,
	permanentReward = 54,
	cost = 20,
	time = 34,
	permanentFirstBonus = 47,
	unlockEpisode = 18,
	mapId = 13,
	decryptId = 12,
	permanentRewardList = 51
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	battleDesc = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
