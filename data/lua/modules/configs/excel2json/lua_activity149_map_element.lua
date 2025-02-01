module("modules.configs.excel2json.lua_activity149_map_element", package.seeall)

slot1 = {
	mapId = 2,
	res = 4,
	tipOffsetPos = 6,
	effect = 7,
	id = 1,
	pos = 3,
	resScale = 5
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
