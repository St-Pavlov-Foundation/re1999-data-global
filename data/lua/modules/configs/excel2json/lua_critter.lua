module("modules.configs.excel2json.lua_critter", package.seeall)

slot1 = {
	eventTimes = 16,
	name = 2,
	rare = 3,
	specialRate = 12,
	banishBonus = 13,
	raceTag = 11,
	catalogue = 14,
	desc = 7,
	relation = 17,
	story = 19,
	attributeIncrRate = 9,
	foodLike = 15,
	icon = 6,
	trainTime = 10,
	mutateSkin = 5,
	line = 18,
	baseAttribute = 8,
	normalSkin = 4,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {
	line = 3,
	name = 1,
	story = 4,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
