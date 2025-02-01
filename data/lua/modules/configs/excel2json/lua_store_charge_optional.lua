module("modules.configs.excel2json.lua_store_charge_optional", package.seeall)

slot1 = {
	id = 2,
	goodsId = 1,
	rare = 3,
	items = 4
}
slot2 = {
	"goodsId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
