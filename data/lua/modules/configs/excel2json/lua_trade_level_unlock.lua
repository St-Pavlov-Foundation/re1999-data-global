module("modules.configs.excel2json.lua_trade_level_unlock", package.seeall)

slot1 = {
	itemType = 7,
	name = 2,
	levelupDes = 5,
	type = 4,
	id = 1,
	icon = 3,
	sort = 6
}
slot2 = {
	"id"
}
slot3 = {
	levelupDes = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
