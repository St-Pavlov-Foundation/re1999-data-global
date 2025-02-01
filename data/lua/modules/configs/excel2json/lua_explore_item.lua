module("modules.configs.excel2json.lua_explore_item", package.seeall)

slot1 = {
	icon = 6,
	name = 3,
	interactEffect = 11,
	type = 2,
	effect = 10,
	isClientStackable = 9,
	desc = 4,
	audioId = 7,
	desc2 = 5,
	id = 1,
	isStackable = 8,
	isReserve = 12
}
slot2 = {
	"id"
}
slot3 = {
	desc2 = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
