module("modules.configs.excel2json.lua_room_order_quality", package.seeall)

slot1 = {
	goodsWeight = 3,
	quality = 1,
	price = 2,
	typeCount = 4
}
slot2 = {
	"quality"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
