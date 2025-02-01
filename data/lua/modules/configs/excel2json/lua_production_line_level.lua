module("modules.configs.excel2json.lua_production_line_level", package.seeall)

slot1 = {
	cost = 4,
	effect = 3,
	changeFormulaId = 5,
	id = 2,
	groupId = 1,
	icon = 7,
	needRoomLevel = 8,
	modulePart = 6
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
