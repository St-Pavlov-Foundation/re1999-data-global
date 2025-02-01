module("modules.configs.excel2json.lua_activity144_item", package.seeall)

slot1 = {
	isStackable = 9,
	name = 2,
	useDesc = 3,
	isShow = 10,
	effect = 11,
	sources = 12,
	rare = 7,
	desc = 4,
	subType = 5,
	id = 1,
	icon = 6,
	highQuality = 8
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
