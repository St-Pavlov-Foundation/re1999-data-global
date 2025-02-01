module("modules.configs.excel2json.lua_equip_enchant", package.seeall)

slot1 = {
	showType = 10,
	attrType = 6,
	quality = 2,
	calType = 9,
	value = 8,
	part = 3,
	logic = 4,
	id = 1,
	weight = 7,
	level = 5
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
