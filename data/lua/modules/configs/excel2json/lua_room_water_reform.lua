module("modules.configs.excel2json.lua_room_water_reform", package.seeall)

slot1 = {
	itemId = 3,
	blockType = 1,
	blockId = 2
}
slot2 = {
	"blockType"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
