module("modules.configs.excel2json.lua_equip", package.seeall)

slot1 = {
	isSpRefine = 11,
	name = 2,
	name_en = 3,
	skillName = 4,
	upperLimit = 17,
	desc = 13,
	isExpEquip = 10,
	strengthType = 8,
	tag = 9,
	icon = 5,
	sources = 15,
	useDesc = 14,
	skillType = 7,
	rare = 6,
	id = 1,
	canShowHandbook = 16,
	useSpRefine = 12
}
slot2 = {
	"id"
}
slot3 = {
	skillName = 2,
	name = 1,
	useDesc = 4,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
