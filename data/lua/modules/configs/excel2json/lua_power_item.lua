module("modules.configs.excel2json.lua_power_item", package.seeall)

slot1 = {
	expireTime = 7,
	name = 2,
	useDesc = 8,
	expireType = 6,
	effect = 10,
	sources = 11,
	rare = 4,
	desc = 9,
	id = 1,
	icon = 3,
	highQuality = 5
}
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	useDesc = 2,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
