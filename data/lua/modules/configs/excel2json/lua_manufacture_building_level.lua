module("modules.configs.excel2json.lua_manufacture_building_level", package.seeall)

slot1 = {
	cost = 4,
	effect = 3,
	id = 2,
	productions = 5,
	groupId = 1,
	needTradeLevel = 6,
	slotCount = 7
}
slot2 = {
	"groupId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
