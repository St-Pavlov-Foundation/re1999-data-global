module("modules.configs.excel2json.lua_auto_chess_mall", package.seeall)

slot1 = {
	groups = 5,
	capacity = 6,
	showLevel = 4,
	type = 2,
	id = 1,
	canRefresh = 7,
	round = 3,
	isFree = 8
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
