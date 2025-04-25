module("modules.configs.excel2json.lua_auto_chess", package.seeall)

slot1 = {
	star = 2,
	name = 5,
	id = 1,
	type = 3,
	attack = 9,
	attackMode = 13,
	image = 18,
	race = 6,
	moveType = 14,
	tag = 8,
	skillDesc = 12,
	skillIds = 11,
	fixExp = 16,
	subRace = 7,
	hp = 10,
	specialShopCost = 15,
	levelFromMall = 4,
	initBuff = 17
}
slot2 = {
	"id",
	"star"
}
slot3 = {
	skillDesc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
