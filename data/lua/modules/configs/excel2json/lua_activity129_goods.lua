module("modules.configs.excel2json.lua_activity129_goods", package.seeall)

slot1 = {
	id = 1,
	goodsId = 3,
	rare = 2
}
slot2 = {
	"id",
	"rare"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
