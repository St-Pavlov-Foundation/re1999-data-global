module("modules.configs.excel2json.lua_room_trade_barrage", package.seeall)

slot1 = {
	heroId = 4,
	type = 2,
	id = 1,
	icon = 3,
	desc = 5
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
