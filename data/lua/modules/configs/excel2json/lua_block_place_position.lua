module("modules.configs.excel2json.lua_block_place_position", package.seeall)

slot1 = {
	id = 1,
	z = 4,
	x = 2,
	y = 3
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
