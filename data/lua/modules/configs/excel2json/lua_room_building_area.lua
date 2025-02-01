module("modules.configs.excel2json.lua_room_building_area", package.seeall)

slot1 = {
	id = 1,
	icon = 3,
	area = 2,
	occupy = 4
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
