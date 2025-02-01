module("modules.configs.excel2json.lua_weekwalk_scene", package.seeall)

slot1 = {
	map = 2,
	name = 6,
	buffId = 4,
	mapId = 3,
	name_en = 9,
	battleName = 8,
	typeName = 5,
	id = 1,
	icon = 7
}
slot2 = {
	"id"
}
slot3 = {
	name = 2,
	typeName = 1,
	name_en = 4,
	battleName = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
