module("modules.configs.excel2json.lua_rouge_item_static_desc", package.seeall)

slot1 = {
	item1_attr = 3,
	id = 1,
	item3 = 6,
	item2_attr = 5,
	item2 = 4,
	item3_attr = 7,
	item1 = 2
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
