module("modules.configs.excel2json.lua_auto_chess_mall_item", package.seeall)

slot1 = {
	cost = 4,
	context = 3,
	group = 2,
	id = 1,
	weight = 5,
	order = 6
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
