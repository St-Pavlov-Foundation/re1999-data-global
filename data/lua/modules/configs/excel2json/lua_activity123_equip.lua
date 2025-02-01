module("modules.configs.excel2json.lua_activity123_equip", package.seeall)

slot1 = {
	isMain = 4,
	name = 2,
	teamLimit = 15,
	indexLimit = 17,
	decomposeGet = 18,
	composeCost = 19,
	equipId = 1,
	signOffset = 9,
	skillId = 11,
	tag = 14,
	icon = 6,
	activityId = 13,
	packageId = 5,
	specialEffect = 16,
	attrId = 10,
	group = 12,
	rare = 3,
	signIcon = 7,
	iconOffset = 8
}
slot2 = {
	"equipId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
