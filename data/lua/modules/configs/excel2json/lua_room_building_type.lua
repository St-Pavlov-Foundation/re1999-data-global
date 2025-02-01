module("modules.configs.excel2json.lua_room_building_type", package.seeall)

slot1 = {
	icon = 2,
	type = 1
}
slot2 = {
	"type"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
