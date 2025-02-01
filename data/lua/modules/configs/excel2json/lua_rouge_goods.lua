module("modules.configs.excel2json.lua_rouge_goods", package.seeall)

slot1 = {
	weights = 5,
	goodsGroup = 2,
	creator = 6,
	currency = 3,
	id = 1,
	price = 4
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
