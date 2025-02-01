module("modules.configs.excel2json.lua_retro_item_convert", package.seeall)

slot1 = {
	itemId = 2,
	limit = 3,
	version = 5,
	typeId = 1,
	price = 4
}
slot2 = {
	"typeId",
	"itemId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
