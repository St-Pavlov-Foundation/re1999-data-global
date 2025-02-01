module("modules.configs.excel2json.lua_rogue_room", package.seeall)

slot1 = {
	nextRoom = 6,
	name = 2,
	layer = 5,
	type = 7,
	id = 1,
	difficulty = 4,
	nameEn = 3
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
