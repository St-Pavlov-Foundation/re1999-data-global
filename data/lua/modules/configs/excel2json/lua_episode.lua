module("modules.configs.excel2json.lua_episode", package.seeall)

slot1 = {
	unlockEpisode = 17,
	name = 4,
	retroFirstBonus = 40,
	dayChangeBonus = 23,
	chapterId = 2,
	preEpisode = 16,
	pic = 14,
	beforeStory = 8,
	battleDesc = 7,
	afterStory = 10,
	saveDayNum = 37,
	navigationpic = 30,
	battleId = 22,
	icon = 15,
	freeBonus = 34,
	desc = 6,
	bgmevent = 29,
	permanentRewardDisplayList = 49,
	displayMark = 38,
	autoSkipStory = 11,
	lockTime = 39,
	rewardDisplayList = 27,
	retroAdvancedBonus = 42,
	freeDisplayList = 35,
	advancedBonus = 26,
	retroRewardDisplayList = 43,
	year = 31,
	permanentAdvancedBonus = 48,
	id = 1,
	retroBonus = 41,
	chainEpisode = 45,
	bonus = 25,
	dayNum = 36,
	retroRewardList = 44,
	type = 3,
	reward = 51,
	rewardList = 28,
	firstBonus = 24,
	retroReward = 52,
	story = 9,
	elementList = 18,
	firstBattleId = 21,
	failCost = 20,
	permanentReward = 53,
	name_En = 5,
	permanentBonus = 47,
	cost = 19,
	time = 33,
	permanentFirstBonus = 46,
	canUseRecord = 32,
	mapId = 13,
	decryptId = 12,
	permanentRewardList = 50
}
slot2 = {
	"id"
}
slot3 = {
	battleDesc = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
