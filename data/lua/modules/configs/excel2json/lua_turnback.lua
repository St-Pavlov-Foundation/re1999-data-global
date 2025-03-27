module("modules.configs.excel2json.lua_turnback", package.seeall)

slot1 = {
	endStory = 8,
	name = 3,
	offlineDays = 4,
	monthCardAddedId = 19,
	additionRate = 14,
	additionType = 13,
	bonusPointMaterial = 18,
	durationDays = 6,
	endTime = 20,
	additionChapterIds = 15,
	buyDoubleBonusPrice = 22,
	bindActivityId = 2,
	taskBonusMailId = 9,
	startStory = 7,
	canBuyDoubleBonus = 21,
	bonusList = 23,
	jumpId = 16,
	priority = 17,
	onlineDurationDays = 24,
	additionDurationDays = 12,
	condition = 5,
	onceBonus = 11,
	id = 1,
	subModuleIds = 10
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
