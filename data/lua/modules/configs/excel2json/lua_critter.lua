module("modules.configs.excel2json.lua_critter", package.seeall)

slot1 = {
	eventTimes = 15,
	name = 2,
	banishBonus = 12,
	rare = 3,
	specialRate = 11,
	raceTag = 10,
	mutateSkin = 5,
	desc = 6,
	catalogue = 13,
	story = 18,
	attributeIncrRate = 8,
	foodLike = 14,
	trainTime = 9,
	relation = 16,
	line = 17,
	baseAttribute = 7,
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
