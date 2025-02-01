module("modules.configs.excel2json.lua_insight_item", package.seeall)

slot1 = {
	heroRares = 5,
	name = 2,
	useDesc = 8,
	heroRank = 6,
	desc = 9,
	effect = 11,
	rare = 4,
	expireHours = 7,
	sources = 12,
	useTitle = 10,
	id = 1,
	icon = 3
}
slot2 = {
	"id"
}
slot3 = {
	useTitle = 4,
	name = 1,
	useDesc = 2,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
