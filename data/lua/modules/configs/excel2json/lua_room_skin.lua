module("modules.configs.excel2json.lua_room_skin", package.seeall)

slot1 = {
	bannerIcon = 8,
	activity = 6,
	name = 5,
	type = 2,
	itemId = 4,
	priority = 11,
	rare = 10,
	desc = 9,
	equipEffPos = 14,
	sources = 15,
	model = 12,
	id = 1,
	icon = 7,
	equipEffSize = 13,
	buildId = 3
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
