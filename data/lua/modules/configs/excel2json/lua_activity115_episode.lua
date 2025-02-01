module("modules.configs.excel2json.lua_activity115_episode", package.seeall)

slot1 = {
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
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	conditionStr = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
